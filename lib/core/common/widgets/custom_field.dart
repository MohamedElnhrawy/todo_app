import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      this.validator,
      required this.controller,
      this.filled = false,
      this.fillColor,
      this.obSecureText = false,
      this.readOnly = false,
      this.required = false,
      this.suffixIcon,
      this.hintText,
      this.keyboardType,
      this.overrideValidator = false,
      this.hintStyle,
      this.fieldTitle});

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColor;
  final bool obSecureText;
  final bool readOnly;
  final bool required;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final String? fieldTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (fieldTitle != null || required)
            ? Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    text: fieldTitle ?? (required? hintText : ''),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black
                    ),
                    children: !required
                        ? null
                        : [
                            const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colours.redColor,
                                )),
                          ],
                  ),
                ),
              )
            : const SizedBox(
                width: 0,
                height: 0,
              ),
        TextFormField(
          controller: controller,
          validator: overrideValidator
              ? validator
              : (value) {
                  if (!required) return null;
                  if (value == null || value.isEmpty) {
                    return context.l10n.required_field;
                  }
                  return validator?.call(value);
                },
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          keyboardType: keyboardType,
          obscureText: obSecureText,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: filled,
            fillColor: fillColor,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle ??
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
