import 'package:flutter/material.dart';
import 'package:segura_app/button/primary_button.dart';
import 'package:segura_app/button/square_button.dart';
import 'package:segura_app/class/password_class.dart';
import 'package:segura_app/mixin/validator_mixin.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/widget/default_input.dart';
import 'package:segura_app/widget/select_item_widget.dart';
import 'package:unicons/unicons.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required Function callback,
    required PasswordTypeEnum type,
  })  : _callback = callback,
        _type = type;

  final Function _callback;
  final PasswordTypeEnum _type;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> with ValidatorMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordClass _passwordClass = PasswordClass();

  String _password = "";
  String _size = "8";
  bool _isSelected = true;
  bool _isNew = true;
  List<String> _listSelected = [PasswordEnum.LOWER_CASE.name];

  final double _height = 16;

  void _generatePassword() {
    if (_formKey.currentState!.validate()) {
      if (_isSelected) {
        setState(() => _password =
            _passwordClass.passwordGenerator(_listSelected, int.parse(_size)));
        FocusScope.of(context).unfocus();
      } else
        setState(() => _password = "");

      _isNew = false;
    }
  }

  void _listSelecteds(List<dynamic> value) {
    setState(() {
      _listSelected = value.map((item) => item.toString()).toList();
      _isSelected = _listSelected.isEmpty ? false : true;
    });
  }

  void _usePassword() {
    widget._callback(_password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PASSWORD_GENERATOR,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: _height),
                Text(
                  NOTE_DESCRIPTION,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Text(
                  PASSWORD_CHARACTERS,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: _height),
                SelectItemWidget(
                  callback: (value) => _listSelecteds(value),
                  initValue: [PasswordEnum.LOWER_CASE.name],
                  list: listPassword,
                ),
                const SizedBox(height: 24),
                Text(
                  PASSWORD_SIZE,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: _height),
                Row(
                  children: [
                    Expanded(
                      child: DefaultInput(
                        initialValue: _size,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => setState(() => _size = value!),
                        validator: (value) => isPasswordCharactersInt(value!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SquareButton(
                      callback: () => _generatePassword(),
                      icon: _isNew ? UniconsLine.check : UniconsLine.redo,
                      isPrimary: true,
                    )
                  ],
                ),
                if (_password.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              _password,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            Text(
                              PASSWORD_CREATED,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: _height),
                          ],
                        ),
                      ),
                      SizedBox(height: _height),
                      PrimaryButton(
                        callback: () => _usePassword(),
                        text: PASSWORD_USE,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
