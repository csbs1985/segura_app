import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class DefaultInput extends StatelessWidget {
  final bool? autoFocus;
  final TextEditingController? controller;
  final Function? callback;
  final bool? expands;
  final FocusNode? focusNode;
  final String? hintText;
  final bool inputCircle;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  const DefaultInput({
    Key? key,
    this.autoFocus = false,
    this.controller,
    this.callback,
    this.expands = false,
    this.focusNode,
    this.hintText,
    this.inputCircle = false,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus!,
      controller: controller,
      expands: expands!,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: (value) => callback!(value),
      onSaved: onSaved,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon!) : null,
        hintText: hintText,
        filled: true,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        border: UiBorder.borderCircle,
        enabledBorder: UiBorder.borderCircle,
        focusedBorder: UiBorder.borderCircle,
      ),
    );
  }
}
