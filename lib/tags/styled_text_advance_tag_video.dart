import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';
import 'package:styled_text_advance/widgets/custom_styled_video.dart';
import 'package:video_player/video_player.dart';

// CustomVideoPlayerWithControls implementation should be here or imported from another file

class StyledTextAdvanceVideoTag extends StyledTextAdvanceTagBase {
  /// Optional video width
  final double? width;

  /// Optional video height
  final double? height;

  /// Video alignment relative to the text
  final PlaceholderAlignment alignment;

  /// Action to be called when the video is tapped
  final StyledTextAdvanceTagActionCallback? onTap;

  StyledTextAdvanceVideoTag({
    this.width,
    this.height,
    this.alignment = PlaceholderAlignment.middle,
    this.onTap,
  });

  @override
  InlineSpan createSpan({
    required BuildContext context,
    String? text,
    String? textContent,
    List<InlineSpan>? children,
    required Map<String?, String?> attributes,
    GestureRecognizer? recognizer,
  }) {
    // Determine if the textContent is a network URL or a local asset
    final isNetworkVideo = textContent != null &&
        (textContent.startsWith('http://') ||
            textContent.startsWith('https://'));

    final String videoSource = textContent ?? "";

    // Initializing VideoPlayerController based on video source type
    VideoPlayerController videoController = isNetworkVideo
        ? VideoPlayerController.network(videoSource)
        : VideoPlayerController.asset(videoSource);

    // Create the custom video player widget with controls
    Widget videoWidget = FutureBuilder(
      future: videoController.initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Use CustomVideoPlayerWithControls here, ensuring the video player is sized appropriately
          return CustomVideoPlayerWithControls(
            controller: videoController,
            width: width, // Pass optional width
            height: height, // Pass optional height
          );
        } else {
          // Placeholder or loading indicator until the video is initialized
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // Wrapping videoWidget with GestureDetector if onTap is provided
    if (onTap != null) {
      videoWidget = GestureDetector(
        child: videoWidget,
        onTap: () => onTap!(text, attributes),
      );
    }

    // Create an InlineSpan for the video, embedding the videoWidget
    return WidgetSpan(
      child: SizedBox(width: width, height: height, child: videoWidget),
      alignment: alignment,
    );
  }
}
