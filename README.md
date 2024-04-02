# StyledTextAdvance

Text widget with formatted text using tags. Makes it easier to use formatted text in multilingual applications.

Formatting is set in the text using **xml tags**, for which styles and other behaviors are defined separately. It is also possible to insert icons and widgets through tags.

You can set the click handler for the tag, through a tag definition class `StyledTextAdvanceActionTag`.


## Table of Contents

- [Getting Started](#getting-Started)
  - [Escaping & special characters](#escaping--special-characters)
  - [Line breaks](#line-breaks)
- [Usage examples](#usage-examples)
  - [How to insert a widget into text](#an-example-of-inserting-an-input-field-widget-in-place-of-a-tag)

## Getting Started

In your flutter project add the dependency:

```dart
dependencies:
  ...
  styled_text_advance: ^[version]
```

Import package:

```dart
import 'package:styled_text_advance/styled_text_advance.dart';

```

### Escaping & special characters

Tag attributes must be enclosed in double quotes, for example: `<link href="https://flutter.dev">`.

You need to escape specific XML characters in text:
```
Original character  Escaped character
------------------  -----------------
"                   &quot;
'                   &apos;
&                   &amp;
<                   &lt;
>                   &gt;
<space>             &space;
```

### Line breaks

By default, line breaks are not ignored, all line breaks `\n` are automatically translated into the `<br/>` tag. To disable this behavior, you can set the `newLineAsBreaks` parameter to `false` and insert the `<br/>` tag where you want to break to a new line.

## Usage examples

### An example of making parts of text bold:
```dart
StyledTextAdvance(
  text: 'Test: <bold>bold</bold> text.',
  tags: {
    'bold': StyledTextAdvanceTag(style: TextStyle(fontWeight: FontWeight.bold)),
  },
)
```
![](https://github.com/andyduke/styled_text_advance_package/raw/master/screenshots/1-bold.png)

---

### Example of highlighting a part of the text by different styles:
```dart
StyledTextAdvance(
  text: 'Test: <bold>bold</bold> and <red>red color</red> text.',
  tags: {
    'bold': StyledTextAdvanceTag(style: TextStyle(fontWeight: FontWeight.bold)),
    'red': StyledTextAdvanceTag(style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
  },
)
```
![](https://github.com/andyduke/styled_text_advance_package/raw/master/screenshots/2-bold-and-color.png)

---

### Example of inserting icons into the text:
```dart
StyledTextAdvance(
  text: 'Text with alarm <alarm/> icon.',
  tags: {
    'alarm': StyledTextAdvanceIconTag(Icons.alarm),
  },
)
```
![](https://github.com/andyduke/styled_text_advance_package/raw/master/screenshots/3-icon.png)

---

### Example of using a tag handler:
```dart
StyledTextAdvance(
  text: 'Text with <link href="https://flutter.dev">link</link> inside.',
  tags: {
    'link': StyledTextAdvanceActionTag(
      (String? text, Map<String?, String?> attrs) => {
        final String link = attrs['href'];
        print('The "$link" link is tapped.');
      },
      style: TextStyle(decoration: TextDecoration.underline),
    ),
  },
)
```
![](https://github.com/andyduke/styled_text_advance_package/raw/master/screenshots/4-link.png)

---

### Example of using a custom tag attributes handler, highlights text with the color specified in the "text" attribute of the tag:
```dart
StyledTextAdvance(
  text: 'Text with custom <color text="#ff5500">color</color> text.',
  tags: {
    'color': StyledTextAdvanceCustomTag(
        baseStyle: TextStyle(fontStyle: FontStyle.italic),
        parse: (baseStyle, attributes) {
          if (attributes.containsKey('text') &&
              (attributes['text'].substring(0, 1) == '#') &&
              attributes['text'].length >= 6) {
            final String hexColor = attributes['text'].substring(1);
            final String alphaChannel = (hexColor.length == 8) ? hexColor.substring(6, 8) : 'FF';
            final Color color = Color(int.parse('0x$alphaChannel' + hexColor.substring(0, 6)));
            return baseStyle.copyWith(color: color);
          } else {
            return baseStyle;
          }
        }),
  },
)
```
---

### An example of inserting an input field widget in place of a tag:
```dart
StyledTextAdvance(
  text: 'Text with <input/> inside.',
  tags: {
    'input': StyledTextAdvanceWidgetTag(
      TextField(
        decoration: InputDecoration(
          hintText: 'Input',
        ),
      ),
      size: Size.fromWidth(200),
      constraints: BoxConstraints.tight(Size(100, 50)),
    ),
  },
)
```
---

### An example of using a widget with the ability to select rich text:
```dart
StyledTextAdvance.selectable(
  text: 'Test: <bold>bold</bold> text.',
  tags: {
    'bold': StyledTextAdvanceTag(style: TextStyle(fontWeight: FontWeight.bold)),
  },
)
```


### Specifying the text style

**NEW**
```dart
StyledTextAdvance(
  text: 'Example: <b>bold</b> text.',
  tags: {
    'b': StyledTextAdvanceTag(style: TextStyle(fontWeight: FontWeight.bold)),
  },
)
```

**NEW**
```dart
StyledTextAdvance(
  text: 'Text with alarm <alarm/> icon.',
  tags: {
    'alarm': StyledTextAdvanceIconTag(Icons.alarm),
  },
)
```
### Specifying a tap handler 

**NEW**
```dart
StyledTextAdvance(
  text: 'Text with <link href="https://flutter.dev">link</link> inside.',
  tags: {
    'link': StyledTextAdvanceActionTag(
      (_, attrs) => _openLink(context, attrs),
      style: TextStyle(decoration: TextDecoration.underline),
    ),
  },
)
```

**NEW**
```dart
StyledTextAdvance(
  text: 'Text with custom <color text="#ff5500">color</color> text.',
  tags: {
    'color': StyledTextAdvanceCustomTag(
        baseStyle: TextStyle(fontStyle: FontStyle.italic),
        parse: (baseStyle, attributes) {
          // Parser code here...
        }),
  },
)
```

Specifying the image handler #

**IMAGE**
```dart

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

**AUDIO**
StyledTextAdvance(
  text: 'Here is a local audio file: <audio>assets/audio.mp3</audio> and a network audio file: <audio>https://example.com/audio.mp3</audio>.',
  tags: {
    'audio': StyledTextAdvanceAudioTag(
      onTap: (String? text, Map<String?, String?>? attributes) {
        // Handle audio play action here. This might involve using the 'audioplayers' package
        // to play the audio file specified in `text` or an attribute.
      },
    ),
  },
),
