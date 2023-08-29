import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class SelectItemWidget extends StatefulWidget {
  const SelectItemWidget({
    super.key,
    required Function callback,
    required List<dynamic> list,
    List<dynamic>? initValue,
  })  : _callback = callback,
        _initValue = initValue,
        _list = list;

  final Function _callback;
  final List<dynamic>? _initValue;
  final List<dynamic> _list;

  @override
  _SelectItemWidgetState createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
  List<dynamic> _listSelected = [];

  @override
  void initState() {
    super.initState();
    _listSelected = widget._initValue!;
  }

  void _selectCharacter(String name) {
    setState(() {
      _listSelected.contains(name)
          ? _listSelected.remove(name)
          : _listSelected.add(name);
    });

    widget._callback(_listSelected);
  }

  bool isCharacters(String name) {
    return _listSelected.contains(name) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: widget._list.map((item) {
        return GestureDetector(
          onTap: () => _selectCharacter(item.name),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
              color: isCharacters(item.name)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).chipTheme.backgroundColor,
              borderRadius: BorderRadius.circular(UiBorder.circle),
            ),
            child: Text(
              item.value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
      }).toList(),
    );
  }
}
