import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';
import 'package:audioplayers/audioplayers.dart';

class StyledTextAdvanceAudioTag extends StyledTextAdvanceTagBase {
  /// Audio file URL or local asset path
  final String? source;

  /// Action to be called when the audio is tapped
  final StyledTextAdvanceTagActionCallback? onTap;

  StyledTextAdvanceAudioTag({this.source, this.onTap});

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
    final isNetworkAudio = textContent != null &&
        (textContent.startsWith('http://') ||
            textContent.startsWith('https://'));

    final audioPlayer = AudioPlayer();
    // Initialize a boolean to manage play/pause state
    bool isPlaying = false;

    // Create a row of audio control buttons
    Widget audioControls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: () async {
            // Implement skipping backwards, e.g., restart or move to previous track
            await audioPlayer.seek(Duration(seconds: 0)); // Example: Restart
          },
        ),
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () async {
            if (isPlaying) {
              await audioPlayer.pause();
            } else {
              if (isNetworkAudio) {
                await audioPlayer.play(UrlSource(textContent!));
              } else {
                await audioPlayer.play(DeviceFileSource(textContent!));
              }
            }
            isPlaying = !isPlaying;

            // If an onTap callback is provided, call it
            onTap?.call(text, attributes);
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: () async {
            // Implement skipping forward, e.g., jump ahead 30 seconds or to next track
            final position = await audioPlayer.getCurrentPosition();
            final duration = await audioPlayer.getDuration();
            final newPos = position! + Duration(seconds: 30);
            if (newPos < duration!) {
              await audioPlayer.seek(newPos);
            } else {
              // Optionally, move to next track or restart
            }
          },
        ),
      ],
    );

    // Create an InlineSpan for the audio control
    final InlineSpan span = WidgetSpan(
      child: audioControls,
      alignment: PlaceholderAlignment.middle, // Default alignment
    );

    return span;
  }
}

class TextWithAudioWidget extends StatefulWidget {
  final String textContent;

  TextWithAudioWidget({Key? key, required this.textContent}) : super(key: key);

  @override
  _TextWithAudioWidgetState createState() => _TextWithAudioWidgetState();
}

class _TextWithAudioWidgetState extends State<TextWithAudioWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    if (widget.textContent.contains('<audio')) {
      // Extract the URL
      final RegExp regExp = RegExp(r'<audio src="(.*?)"></audio>');
      final match = regExp.firstMatch(widget.textContent);
      final audioSrc = match?.group(1) ?? "";

      return Column(
        children: [
          Text("Audio content available"),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  // Implement skip backward
                },
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.pause();
                  } else {
                    audioPlayer.play(UrlSource(audioSrc));
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  // Implement skip forward
                },
              ),
            ],
          ),
        ],
      );
    } else {
      return Text(widget.textContent);
    }
  }
}
