import 'package:flutter/material.dart';
import 'package:styled_text_advance/styled_text_advance.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_img.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_video.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StyledTextAdvance Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  void _alert(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tapped'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openLink(BuildContext context, Map<String?, String?> attrs) {
    final String link = attrs['href'] ?? "";

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open Link'),
          content: Text(link),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('StyledTextAdvance Demo'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Simple formatted text
                StyledTextAdvance(
                  text: 'Test: <b>bold</b> text.',
                  tags: {
                    'b': StyledTextAdvanceTag(
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  },
                ),

                // Text with quotes
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: 'Quoted Test: <b>&quot;bold&quot;</b> text.',
                  tags: {
                    'b': StyledTextAdvanceTag(
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  },
                ),

                // Multiline text without breaks
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: """Multiline text  (no breaks)""",
                  tags: {
                    'b': StyledTextAdvanceTag(
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  },
                ),

                // Multiline text with breaks
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: """Multiline text (with breaks)""",
                  newLineAsBreaks: true,
                  tags: {
                    'b': StyledTextAdvanceTag(
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  },
                ),

                // Custom tags styles
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text:
                      'Test: <bold>bold</bold> and <red>red color</red> text.',
                  tags: {
                    'bold': StyledTextAdvanceTag(
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    'red': StyledTextAdvanceTag(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  },
                ),

                // Icon
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: 'Text with alarm <alarm/> icon.',
                  tags: {
                    'alarm': StyledTextAdvanceIconTag(Icons.alarm),
                  },
                ),

                // Image
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text:
                      'Here is a local image: <img>assets/image.jpg</img> and a network image: <img>https://example.com/image.jpg</img>.',
                  tags: {
                    'img': StyledTextAdvanceImageTag(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  },
                ),

                // video
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: "Here's a video: <video>assets/video.mp4</video>",
                  tags: {
                    "video": StyledTextAdvanceVideoTag(
                      //width: 300, // Optional: specify width
                      //height: 200, // Optional: specify height
                      onTap: () {
                        // Optional: define what happens when the video is tapped
                      },
                    ),
                  },
                ),

                // Action
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: 'Text with <action>action</action> inside.',
                  tags: {
                    'action': StyledTextAdvanceActionTag(
                      (_, attrs) => _alert(context),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                  },
                ),

                // Link
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text:
                      'Text with <link href="https://flutter.dev">link</link> inside.',
                  tags: {
                    'link': StyledTextAdvanceActionTag(
                      (_, attrs) => _openLink(context, attrs),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                  },
                ),

                // SelectableText with Link
                const SizedBox(height: 20),
                StyledTextAdvance.selectable(
                  text:
                      'Text with <link href="https://flutter.dev">link</link> inside.',
                  tags: {
                    'link': StyledTextAdvanceActionTag(
                      (_, attrs) => _openLink(context, attrs),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                  },
                ),

                // Text with superscript
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: "Famous equation: E=mc<sup>2</sup>",
                  tags: {
                    'sup': StyledTextAdvanceWidgetBuilderTag(
                      (_, attributes, textContent) {
                        return Transform.translate(
                          offset: const Offset(0.5, -4),
                          child: Text(
                            textContent ?? "",
                            textScaleFactor: 0.85,
                          ),
                        );
                      },
                    ),
                  },
                ),

                // Text with subscript
                const SizedBox(height: 20),
                StyledTextAdvance(
                  text: "The element of life: H<sub>2</sub>0",
                  tags: {
                    'sub': StyledTextAdvanceWidgetBuilderTag(
                      (_, attributes, textContent) {
                        return Transform.translate(
                          offset: const Offset(0.5, 4),
                          child: Text(
                            textContent ?? "",
                            textScaleFactor: 0.8,
                          ),
                        );
                      },
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
