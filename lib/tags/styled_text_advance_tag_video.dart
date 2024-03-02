import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';
import 'package:styled_text_advance/widgets/custom_styled_video.dart';
import 'package:video_player/video_player.dart';

// CustomVideoPlayerWithControls should be defined as per your earlier code
// It's a widget that takes a VideoPlayerController and optional width/height parameters

class StyledTextAdvanceVideoTag extends StyledTextAdvanceTagBase {
  final double? width;
  final double? height;
  final PlaceholderAlignment alignment;
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

    // Initializing VideoPlayerController based on the video source type
    VideoPlayerController videoController = isNetworkVideo
        ? VideoPlayerController.networkUrl(Uri.parse(videoSource))
        : VideoPlayerController.asset(videoSource);

    // Create the custom video player widget with controls using a FutureBuilder
    Widget videoWidget = FutureBuilder(
      future: videoController.initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the future is complete, return the video player
          return CustomVideoPlayerWithControls(
              controller: videoController, width: width, height: height);
        } else {
          // Otherwise, show a loading indicator
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // Define an intermediate onTap handler
    void handleOnTap() {
      // Toggle play/pause state
      if (videoController.value.isPlaying) {
        videoController.pause();
      } else {
        videoController.play();
      }

      // If an external onTap is provided, invoke it
      if (onTap != null) {
        onTap!(text, attributes); // Passing the expected arguments
      }
    }

    // Wrap the video widget in a GestureDetector to handle onTap
    videoWidget = GestureDetector(
      onTap: handleOnTap,
      child: videoWidget,
    );

    // Return an InlineSpan using WidgetSpan to embed the video widget
    return WidgetSpan(
      child: videoWidget,
      alignment: alignment,
    );
  }
}
