import 'dart:ui' as ui show TextHeightBehavior, BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:styled_text_advance/tags/styled_text_advance_tag_base.dart';
import 'package:styled_text_advance/widgets/custom_styled_text_advance.dart';

///
/// Text widget with formatting via tags.
///
/// Formatting is specified as xml tags. For each tag, you can specify a style, icon, etc. in the [tags] parameter.
///
/// Consider using the [CustomStyledTextAdvance] instead if you need more customisation.
///
/// Example:
/// ```dart
/// StyledTextAdvance(
///   text: '&lt;red&gt;Red&lt;/red&gt; text.',
///   tags: [
///     'red': StyledTextAdvanceTag(style: TextStyle(color: Colors.red)),
///   ],
/// )
/// ```
/// See also:
///
/// * [TextStyle], which discusses how to style text.
///
class StyledTextAdvance extends StatelessWidget {
  /// The text to display in this widget. The text must be valid xml.
  ///
  /// Tag attributes must be enclosed in double quotes.
  /// You need to escape specific XML characters in text:
  ///
  /// ```
  /// Original character  Escaped character
  /// ------------------  -----------------
  /// "                   &quot;
  /// '                   &apos;
  /// &                   &amp;
  /// <                   &lt;
  /// >                   &gt;
  /// <space>             &space;
  /// ```
  ///
  final String text;

  /// Treat newlines as line breaks.
  final bool newLineAsBreaks;

  /// Is text selectable?
  final bool selectable;

  /// Default text style.
  final TextStyle? style;

  /// Map of tag assignments to text style classes and tag handlers.
  ///
  /// Example:
  /// ```dart
  /// StyledTextAdvance(
  ///   text: '&lt;red&gt;Red&lt;/red&gt; text.',
  ///   tags: [
  ///     'red': StyledTextAdvanceTag(style: TextStyle(color: Colors.red)),
  ///   ],
  /// )
  /// ```
  final Map<String, StyledTextAdvanceTagBase> tags;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double? textScaler;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  /// Create a text widget with formatting via tags.
  ///
  StyledTextAdvance({
    Key? key,
    required this.text,
    this.newLineAsBreaks = true,
    this.style,
    Map<String, StyledTextAdvanceTagBase>? tags,
    this.textAlign,
    this.textDirection,
    this.softWrap = true,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : tags = tags ?? const {},
        selectable = false,
        _focusNode = null,
        _showCursor = false,
        _autofocus = false,
        _toolbarOptions = null,
        _contextMenuBuilder = null,
        _selectionControls = null,
        _selectionHeightStyle = null,
        _selectionWidthStyle = null,
        _onSelectionChanged = null,
        _magnifierConfiguration = null,
        _cursorWidth = null,
        _cursorHeight = null,
        _cursorRadius = null,
        _cursorColor = null,
        _dragStartBehavior = DragStartBehavior.start,
        _enableInteractiveSelection = false,
        _onTap = null,
        _scrollPhysics = null,
        _semanticsLabel = null,
        super(key: key);

  /// Create a selectable text widget with formatting via tags.
  ///
  /// See [SelectableText.rich] for more options.
  const StyledTextAdvance.selectable({
    Key? key,
    required this.text,
    this.newLineAsBreaks = false,
    this.style,
    Map<String, StyledTextAdvanceTagBase>? tags,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.maxLines,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    FocusNode? focusNode,
    bool showCursor = false,
    bool autofocus = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after Flutter v3.3.0-0.5.pre.',
    )
    // ignore: deprecated_member_use
    ToolbarOptions? toolbarOptions,
    EditableTextContextMenuBuilder contextMenuBuilder =
        _defaultContextMenuBuilder,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    SelectionChangedCallback? onSelectionChanged,
    TextMagnifierConfiguration? magnifierConfiguration,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection = true,
    GestureTapCallback? onTap,
    ScrollPhysics? scrollPhysics,
    String? semanticsLabel,
  })  : tags = tags ?? const {},
        selectable = true,
        softWrap = true,
        overflow = TextOverflow.clip,
        locale = null,
        _focusNode = focusNode,
        _showCursor = showCursor,
        _autofocus = autofocus,
        _toolbarOptions = toolbarOptions ??
            // ignore: deprecated_member_use
            const ToolbarOptions(
              selectAll: true,
              copy: true,
            ),
        _contextMenuBuilder = contextMenuBuilder,
        _selectionHeightStyle = selectionHeightStyle,
        _selectionWidthStyle = selectionWidthStyle,
        _selectionControls = selectionControls,
        _onSelectionChanged = onSelectionChanged,
        _magnifierConfiguration = magnifierConfiguration,
        _cursorWidth = cursorWidth,
        _cursorHeight = cursorHeight,
        _cursorRadius = cursorRadius,
        _cursorColor = cursorColor,
        _dragStartBehavior = dragStartBehavior,
        _enableInteractiveSelection = enableInteractiveSelection,
        _onTap = onTap,
        _scrollPhysics = scrollPhysics,
        _semanticsLabel = semanticsLabel,
        super(key: key);

  final FocusNode? _focusNode;
  final bool _showCursor;
  final bool _autofocus;

  // ignore: deprecated_member_use
  final ToolbarOptions? _toolbarOptions;
  final EditableTextContextMenuBuilder? _contextMenuBuilder;
  final TextSelectionControls? _selectionControls;
  final ui.BoxHeightStyle? _selectionHeightStyle;
  final ui.BoxWidthStyle? _selectionWidthStyle;
  final SelectionChangedCallback? _onSelectionChanged;
  final TextMagnifierConfiguration? _magnifierConfiguration;
  final double? _cursorWidth;
  final double? _cursorHeight;
  final Radius? _cursorRadius;
  final Color? _cursorColor;
  final DragStartBehavior _dragStartBehavior;
  final bool _enableInteractiveSelection;
  final GestureTapCallback? _onTap;
  final ScrollPhysics? _scrollPhysics;
  final String? _semanticsLabel;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  Widget _buildText(BuildContext context, TextSpan textSpan) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final registrar = SelectionContainer.maybeOf(context);

    Widget result = RichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection,
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow:
          overflow ?? textSpan.style?.overflow ?? defaultTextStyle.overflow,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      locale: locale,
      textScaler: TextScaler.linear(
          textScaler ?? MediaQuery.textScalerOf(context) as double),
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      text: textSpan,
      selectionRegistrar: registrar,
      selectionColor: DefaultSelectionStyle.of(context).selectionColor,
    );

    if (registrar != null) {
      result = MouseRegion(
        cursor: SystemMouseCursors.text,
        child: result,
      );
    }

    return result;
  }

  Widget _buildSelectableText(BuildContext context, TextSpan textSpan) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return SelectableText.rich(
      textSpan,
      focusNode: _focusNode,
      showCursor: _showCursor,
      autofocus: _autofocus,
      // ignore: deprecated_member_use
      toolbarOptions: _toolbarOptions,
      contextMenuBuilder: _contextMenuBuilder,
      selectionControls: _selectionControls,
      selectionHeightStyle: _selectionHeightStyle!,
      selectionWidthStyle: _selectionWidthStyle!,
      onSelectionChanged: _onSelectionChanged,
      magnifierConfiguration: _magnifierConfiguration,
      cursorWidth: _cursorWidth!,
      cursorHeight: _cursorHeight,
      cursorRadius: _cursorRadius,
      cursorColor: _cursorColor,
      dragStartBehavior: _dragStartBehavior,
      enableInteractiveSelection: _enableInteractiveSelection,
      onTap: _onTap,
      scrollPhysics: _scrollPhysics,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection,
      // softWrap
      // overflow
      textScaler: TextScaler.linear(
          textScaler ?? MediaQuery.textScalerOf(context) as double),
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      // locale
      strutStyle: strutStyle,
      semanticsLabel: _semanticsLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomStyledTextAdvance(
      style: style,
      newLineAsBreaks: newLineAsBreaks,
      text: text,
      tags: tags,
      builder: selectable ? _buildSelectableText : _buildText,
    );
  }
}
