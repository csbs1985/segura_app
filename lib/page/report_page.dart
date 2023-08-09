import 'package:flutter/material.dart';
import 'package:segura_app/appbar/back_appbar.dart';
import 'package:segura_app/button/primary_button.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/firestore/report_firestore.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/widget/default_input.dart';
import 'package:uuid/uuid.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportFirestore _reportFirestore = ReportFirestore();
  final ToastClass _toastClass = ToastClass();
  final Uuid uuid = const Uuid();

  String _report = "";

  void _setProblem(BuildContext context) async {
    if (_report.isNotEmpty) {
      try {
        Map<String, dynamic> problema = {
          'reportId': uuid.v4(),
          "dateRegistration": DateTime.now().toString(),
          "userId": currentUser.value.userId,
          "problem": _report,
        };
        await _reportFirestore.salvarProblema(problema);
        _toastClass.sucesso(
          context: context,
          text: REPORT_SUCCESS,
        );
        setState(() => _report = "");
      } catch (e) {
        _toastClass.erro(
          context: context,
          text: REPORT_ERROR,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                REPORT,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                REPORT_DESCRIPTION,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              DefaultInput(
                initialValue: _report,
                hintText: REPORT,
                maxLines: null,
                minLines: 1,
                onSaved: (value) => setState(() => _report = value!),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          callback: () => _setProblem(context),
          text: REPORT,
        ),
      ),
    );
  }
}
