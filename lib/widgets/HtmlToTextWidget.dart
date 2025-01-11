import 'package:flutter/cupertino.dart';

class HtmlToTextWidget extends StatelessWidget {
  final String htmlText;

  HtmlToTextWidget({required this.htmlText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: parseHtmlToTextSpans(htmlText),
    );
  }

  TextSpan parseHtmlToTextSpans(String text) {
    final List<TextSpan> spans = [];
    final RegExp tagRegExp = RegExp(r'<(\/?)(b|p)>(.*?)', dotAll: true);
    int lastIndex = 0;

    while (lastIndex < text.length) {
      final match = tagRegExp.firstMatch(text.substring(lastIndex));

      if (match != null) {
        // Add plain text before the tag
        final plainText = text.substring(lastIndex, lastIndex + match.start);
        if (plainText.isNotEmpty) {
          spans.add(TextSpan(text: plainText, style: const TextStyle(fontWeight: FontWeight.normal)));
        }

        final isClosingTag = match.group(1) == '/';
        final tagName = match.group(2);
        final contentStart = lastIndex + match.end;

        if (!isClosingTag) {
          final closingTag = '</$tagName>';
          final closingIndex = text.indexOf(closingTag, contentStart);

          if (closingIndex != -1) {
            final content = text.substring(contentStart, closingIndex);

            if (tagName == 'b') {
              spans.add(TextSpan(text: content, style: const TextStyle(fontWeight: FontWeight.bold)));
            } else if (tagName == 'p') {
              spans.add(parseHtmlToTextSpans(content));
            }

            lastIndex = closingIndex + closingTag.length;
          } else {
            throw Exception('Mismatched tag for <$tagName>');
          }
        } else {
          lastIndex += match.end;
        }
      } else {
        // Add remaining text
        spans.add(TextSpan(text: text.substring(lastIndex), style: const TextStyle(fontWeight: FontWeight.normal)));
        break;
      }
    }

    return TextSpan(children: spans);
  }
}