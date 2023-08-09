import 'package:flutter/material.dart';
import 'package:segura_app/class/note_class.dart';

class CategoryFormModal extends StatefulWidget {
  const CategoryFormModal({
    super.key,
    Map<String, dynamic>? selecionado,
  }) : _selecionado = selecionado;

  final Map<String, dynamic>? _selecionado;

  @override
  State<CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<CategoryFormModal> {
  final NoteClass _noteClass = NoteClass();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
