import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/widget/note_item_widget.dart';

class RecentListWidget extends StatefulWidget {
  const RecentListWidget({super.key});

  @override
  State<RecentListWidget> createState() => _RecentListWidgetState();
}

class _RecentListWidgetState extends State<RecentListWidget> {
  final Map<String, dynamic> _note = {};

  Future<Map<dynamic, dynamic>> get10Recents() async {
    final recentBox = await Hive.openBox('recent');

    Map<dynamic, dynamic> data = {};

    for (int i = 0; i < recentBox.length && i < 10; i++) {
      data[i] = recentBox.get(i);
    }
    return data;
  }

  Future<void> _selectNote(Map<String, dynamic> note) async {
    currentNote.value = NoteModel.fromMap(note);

    context.pushNamed(RouteEnum.NOTE.value,
        pathParameters: {'type': NoteTypeEnum.NOTE.name});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            RECENT,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        FutureBuilder(
          future: get10Recents(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              final data = snapshot.data;

              if (data != null) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    snapshot.data![index].forEach((key, value) {
                      _note[key.toString()] = value;
                    });

                    return NoteItemWidget(
                      item: _note,
                      onTap: () => _selectNote(_note),
                    );
                  },
                );
              } else {
                return const Text('Nenhum dado encontrado.');
              }
            }
          },
        ),
      ],
    );
  }
}
