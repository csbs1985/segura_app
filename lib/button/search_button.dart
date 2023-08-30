import 'package:flutter/material.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:unicons/unicons.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            children: [
              Icon(
                UniconsLine.search,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  SEARCH,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
            ],
          ),
        ),
        onTap: () => widget._callback(),
      ),
    );
  }
}
