import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';
import 'package:video_player/video_player.dart';

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

    Widget videoWidget;

    // Use textContent as the video source, defaulting to an empty string if null
    final String videoSource = textContent ?? "";

    // Initialize the video player controller with a Uri
    VideoPlayerController videoController;
    if (isNetworkVideo) {
      videoController = VideoPlayerController.networkUrl(
          Uri.parse(videoSource)); // Convert String to Uri
    } else {
      videoController = VideoPlayerController.asset(videoSource);
    }

    // Create the video player widget
    videoWidget = FutureBuilder(
      future: videoController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Optionally adjust the aspect ratio and other settings
          return AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: VideoPlayer(videoController),
          );
        } else {
          // Placeholder or loading indicator until the video is initialized
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // Optionally wrap the video widget in a GestureDetector if an onTap callback is provided
    if (onTap != null) {
      videoWidget = GestureDetector(
        child: videoWidget,
        onTap: () => onTap!(text, attributes),
      );
    }

    // Create an InlineSpan for the video
    final InlineSpan span = WidgetSpan(
      child: SizedBox(width: width, height: height, child: videoWidget),
      alignment: alignment,
    );

    return span;
  }
}
