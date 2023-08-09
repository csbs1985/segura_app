import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class DefaultInput extends StatelessWidget {
  final bool? autoFocus;
  final bool? expands;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final String? initialValue;

  const DefaultInput({
    Key? key,
    this.autoFocus = false,
    this.expands = false,
    this.focusNode,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus!,
      expands: expands!,
      focusNode: focusNode,
      initialValue: initialValue,
      keyboardType: keyboardType,
      onChanged: onSaved,
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
        hintStyle: Theme.of(context).textTheme.headlineMedium,
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        border: UiBorder.borderRounded,
        enabledBorder: UiBorder.borderRounded,
        focusedBorder: UiBorder.borderRounded,
      ),
    );
  }
}
