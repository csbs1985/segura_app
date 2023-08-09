import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class FormInput extends StatelessWidget {
  final bool? autoFocus;
  final bool? expands;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? pesquisar;
  final String? initialValue;

  const FormInput({
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
    this.pesquisar = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autofocus: autoFocus!,
        expands: expands!,
        focusNode: focusNode,
        initialValue: initialValue,
        keyboardType: keyboardType,
        onChanged: onSaved,
        onSaved: onSaved,
        cursorColor: Theme.of(context).primaryColor,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          isDense: true,
          hintStyle: Theme.of(context).textTheme.headlineMedium,
          border: UiBorder.borderRounded,
          enabledBorder: UiBorder.borderRounded,
          focusedBorder: UiBorder.borderRounded,
        ),
      ),
    );
  }
}
