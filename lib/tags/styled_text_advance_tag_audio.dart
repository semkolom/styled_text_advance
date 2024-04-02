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

  StyledTextAdvanceAudioTag({
    this.source,
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
    final isNetworkAudio = textContent != null &&
        (textContent.startsWith('http://') ||
            textContent.startsWith('https://'));

    final audioPlayer = AudioPlayer();
    Widget audioWidget = IconButton(
      icon: Icon(Icons.play_arrow),
      onPressed: () async {
        if (isNetworkAudio) {
          await audioPlayer.play(UrlSource(textContent));
        } else {
          await audioPlayer.play(DeviceFileSource(textContent!));
        }

        // If an onTap callback is provided, call it
        if (onTap != null) {
          onTap!(text, attributes);
        }
      },
    );

    // Create an InlineSpan for the audio control
    final InlineSpan span = WidgetSpan(
      child: audioWidget,
      alignment: PlaceholderAlignment.middle, // Default alignment
    );

    return span;
  }
}

class TextWithAudioWidget extends StatelessWidget {
  final String textContent;
  final AudioPlayer audioPlayer = AudioPlayer();

  TextWithAudioWidget({Key? key, required this.textContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ideally, you'd parse and process the textContent to separate text and audio parts
    // For simplicity, this example assumes the whole content is an <audio> tag or plain text
    if (textContent.contains('<audio')) {
      // Extract the URL (simplistic approach, see parsing logic provided earlier)
      final RegExp regExp = RegExp(r'<audio src="(.*?)"></audio>');
      final match = regExp.firstMatch(textContent);
      final audioSrc = match?.group(1) ?? "";

      return Column(
        children: [
          Text("Audio content available"),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => audioPlayer.play(UrlSource(audioSrc)),
          ),
        ],
      );
    } else {
      // If no <audio> tag is found, display the text as is
      return Text(textContent);
    }
  }
}
