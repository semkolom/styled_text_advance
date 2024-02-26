import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag.dart';

/// A class that you can use to specify a callback
/// that will be called when the tag is tapped.
///
class StyledTextAdvanceActionTag extends StyledTextAdvanceTag {
  /// A callback to be called when the tag is tapped.
  final StyledTextAdvanceTagActionCallback onTap;

  StyledTextAdvanceActionTag(
    this.onTap, {
    TextStyle? style,
  }) : super(style: style);

  GestureRecognizer? createRecognizer(
      String? text, Map<String?, String?> attributes) {
    return TapGestureRecognizer()..onTap = () => onTap(text, attributes);
  }
}
