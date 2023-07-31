import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class FormInput extends StatelessWidget {
  final bool? autoFocus;
  final TextEditingController? controller;
  final Function? callback;
  final bool? expands;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? pesquisar;
  final TextStyle? style;

  const FormInput({
    Key? key,
    this.autoFocus = false,
    this.controller,
    this.callback,
    this.expands = false,
    this.focusNode,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.pesquisar = false,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
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
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          border: UiBorder.borderSquared,
          enabledBorder: UiBorder.borderSquared,
          focusedBorder: UiBorder.borderSquared,
        ),
      ),
    );
  }
}
