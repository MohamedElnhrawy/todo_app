import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(this.context,
      {super.key, required this.content, this.style});

  final String content;
  final TextStyle? style;
  final BuildContext context;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late TextSpan textSpan;
  late TextPainter textPainter;
  bool expanded = false;

  @override
  void initState() {
    textSpan = TextSpan(
      text: widget.content,
    );

    textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: expanded ? null : 2)
      ..layout(maxWidth: widget.context.width * .9);

    super.initState();
  }

  @override
  void dispose() {
    textPainter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(
      height: 1.8,
      fontSize: 16,
      color: Colours.neutralTextColor,
    );
    return Container(
      child: textPainter.didExceedMaxLines
          ? RichText(
              text: TextSpan(
                text: expanded
                    ? widget.content
                    : '${widget.content.substring(0, textPainter.getPositionForOffset(
                          Offset(widget.context.width, widget.context.height),
                        ).offset)}...',
                style: widget.style ?? defaultStyle,
                children: [
                  TextSpan(
                      text: expanded ? " show less" : " show More",
                      style: const TextStyle(
                          color: Colours.primaryColor,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            expanded = !expanded;
                          });
                        })
                ],
              ),
            )
          : Text(
              widget.content,
              style: widget.style ?? defaultStyle,
            ),
    );
  }
}
