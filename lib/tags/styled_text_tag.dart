import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text_advance/tags/styled_text_tag_base.dart';

/// The class that you can use to specify the text style for the tag.
///
class StyledTextAdvanceTag extends StyledTextAdvanceTagBase {
  /// The TextStyle to apply to this tag.
  final TextStyle? style;

  StyledTextAdvanceTag({
    this.style,
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
    final TextSpan span = TextSpan(
      text: text,
      style: style,
      children: children,
      recognizer: recognizer,
    );
    return span;
  }
}
