import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/appbar/modal_appbar.dart';
import 'package:segura_app/button/square_button.dart';
import 'package:segura_app/class/category_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/input/default_input.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class CategoryFormModal extends StatefulWidget {
  const CategoryFormModal({
    super.key,
    Map<String, dynamic>? select,
  }) : _select = select;

  final Map<String, dynamic>? _select;

  @override
  State<CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<CategoryFormModal> {
  final CategoryClass _categoryClass = CategoryClass();
  final Uuid _uuid = const Uuid();

  String _categoryCurrent = "";

  Map<String, dynamic> _formCategory = {};

  @override
  void initState() {
    super.initState();
    _fetchCategoryData();
  }

  Future<void> _fetchCategoryData() async {
    if (widget._select!.isNotEmpty) {
      _formCategory = {
        'category': widget._select!['category'],
        'categoryId': widget._select!['categoryId'],
        'userId': widget._select!['userId'],
      };

      _categoryCurrent = widget._select!['category'];
    } else {
      _formCategory = {
        'category': "",
        'categoryId': "",
        'userId': "",
      };
    }
  }

  _deteCategory() {
    _categoryClass.deleteCategory(context, _formCategory);
    context.pop();
  }

  _saveCategory(BuildContext context) {
    if (_formCategory['category'] != "" &&
        _formCategory['category'] != null &&
        _categoryCurrent != _formCategory['category']) {
      setState(() {
        List<String> textos =
            _categoryClass.separateByComma(_formCategory['category']);

        for (var item in textos) {
          if (widget._select!.isNotEmpty) {
            // editar
            _formCategory = {
              'category': item.trim().toLowerCase(),
              'categoryId': _formCategory['categoryId'],
              'userId': _formCategory['userId'],
            };
          } else {
            // criar
            _formCategory = {
              'category': item.trim().toLowerCase(),
              'categoryId': _uuid.v4(),
              'userId': currentUser.value.userId,
            };
          }
          _categoryClass.saveCategory(context, _formCategory);
        }
      });
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ModalAppBar(text: CATEGORIES),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiBorder.rounded),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget._select!.isNotEmpty
                          ? CATEGORY_EDIT
                          : CATEGORY_CREATE,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget._select!.isNotEmpty
                          ? CATEGORY_EDIT_DESCRIPTION
                          : CATEGORY_CREATE_DESCRIPTION,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultInput(
                            initialValue: _formCategory['category'] ?? "",
                            hintText: CATEGORIES,
                            onSaved: (value) => setState(
                                () => _formCategory['category'] = value!),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SquareButton(
                          callback: () => _saveCategory(context),
                          icon: UniconsLine.check,
                          isPrimary: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget._select!.isNotEmpty) const SizedBox(height: 16),
              if (widget._select!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CATEGORY_DELETE,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        CATEGORY_DELETE_DESCRIPTION,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SquareButton(
                            callback: () => context.pop(),
                            icon: UniconsLine.times,
                            isPrimary: false,
                          ),
                          const SizedBox(width: 8),
                          SquareButton(
                            callback: () => _deteCategory(),
                            icon: UniconsLine.check,
                            isPrimary: true,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
