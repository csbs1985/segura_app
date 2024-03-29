import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_espaco.dart';
import 'package:senha_app/theme/ui_texto.dart';

class PadraoInput extends StatelessWidget {
  final bool? autoFocus;
  final TextEditingController? controller;
  final Function? callback;
  final bool? expands;
  final FocusNode? focusNode;
  final String? hintText;
  final bool inputCircular;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? pesquisarIcone;
  final String? Function(String?)? validator;

  const PadraoInput({
    Key? key,
    this.autoFocus = false,
    this.controller,
    this.callback,
    this.expands = false,
    this.focusNode,
    this.hintText,
    this.inputCircular = false,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.pesquisarIcone = false,
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
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: UiCor.textEscuro,
      ),
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: pesquisarIcone! ? const Icon(Icons.search_outlined) : null,
        counterStyle: Theme.of(context).textTheme.headlineSmall,
        hintText: hintText,
        filled: true,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        errorStyle: UiTexto.erro,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: UiEspaco.grande,
          vertical: UiEspaco.medio,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            inputCircular ? UiBorda.circulo : UiBorda.arredondada,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            inputCircular ? UiBorda.circulo : UiBorda.arredondada,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            inputCircular ? UiBorda.circulo : UiBorda.arredondada,
          ),
        ),
      ),
    );
  }
}
