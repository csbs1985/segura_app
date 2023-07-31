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
  final TextEditingController _controleProblema = TextEditingController();
  final ToastClass _toastClass = ToastClass();
  final Uuid uuid = const Uuid();

  String report = "";

  void _setProblem(BuildContext context) async {
    if (report.isNotEmpty) {
      try {
        Map<String, dynamic> problema = {
          'reportId': uuid.v4(),
          "dateRegistration": DateTime.now().toString(),
          "userId": currentUser.value.userId,
          "problem": report,
        };
        await _reportFirestore.salvarProblema(problema);
        _toastClass.sucesso(
          context: context,
          text: REPORT_PROBLEM_SUCCESS,
        );
        _controleProblema.clear();
      } catch (e) {
        _toastClass.erro(
          context: context,
          text: REPORT_PROBLEM_ERROR,
        );
      }
    }
  }

  @override
  void dispose() {
    _controleProblema.dispose();
    super.dispose();
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
                REPORT_PROBLEM,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                REPORT_PROBLEM_DESCRIPTION,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              DefaultInput(
                controller: _controleProblema,
                hintText: REPORT_PROBLEM,
                maxLines: null,
                minLines: 1,
                callback: (value) => setState(() => report = value),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          callback: () => _setProblem(context),
          text: REPORT_PROBLEM,
        ),
      ),
    );
  }
}
