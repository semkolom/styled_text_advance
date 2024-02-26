import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text_advance/tags/styled_text_tag_base.dart';

class StyledTextAdvanceImageTag extends StyledTextAdvanceTagBase {
  /// Image source, which can be a network URL or an asset path.
  final String imageSource;

  /// Image width
  final double? width;

  /// Image height
  final double? height;

  /// How the image should be inscribed into the box.
  final BoxFit? fit;

  /// Aligning the image relative to the text
  final PlaceholderAlignment alignment;

  /// Called when the image is tapped or otherwise activated.
  final StyledTextAdvanceTagActionCallback? onTap;

  StyledTextAdvanceImageTag(
    this.imageSource, {
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
    Widget imageWidget = Image.network(
      imageSource,
      width: width,
      height: height,
      fit: fit,
    );

    if (onTap != null) {
      imageWidget = GestureDetector(
        child: imageWidget,
        onTap: () => onTap!(text, attributes),
      );
    }

    final InlineSpan span = WidgetSpan(
      child: imageWidget,
      alignment: alignment,
    );

    return span;
  }
}
