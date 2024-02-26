import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';

class StyledTextAdvanceImageTag extends StyledTextAdvanceTagBase {
  /// Optional image width
  final double? width;

  /// Optional image height
  final double? height;

  /// How the image should fit within its bounds
  final BoxFit? fit;

  /// Image alignment relative to the text
  final PlaceholderAlignment alignment;

  /// Action to be called when the image is tapped
  final StyledTextAdvanceTagActionCallback? onTap;

  StyledTextAdvanceImageTag({
    this.width,
    this.height,
    this.fit,
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
    final isNetworkImage = textContent != null &&
        (textContent.startsWith('http://') ||
            textContent.startsWith('https://'));

    Widget imageWidget;

    // Use textContent as the image source, defaulting to an empty string if null
    final String imageSource = textContent ?? "";

    // Create the appropriate widget based on the source type
    if (isNetworkImage) {
      imageWidget = Image.network(
        imageSource,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      imageWidget = Image.asset(
        imageSource,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // Wrap the image widget in a GestureDetector if an onTap callback is provided
    if (onTap != null) {
      imageWidget = GestureDetector(
        child: imageWidget,
        onTap: () => onTap!(text, attributes),
      );
    }

    // Create an InlineSpan for the image
    final InlineSpan span = WidgetSpan(
      child: imageWidget,
      alignment: alignment,
    );

    return span;
  }
}
