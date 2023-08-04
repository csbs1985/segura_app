import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_duration.dart';

class ToastClass {
  ShowMToast toast = ShowMToast();

  void erro({
    required BuildContext context,
    required String text,
  }) {
    toast.errorToast(
      alignment: Alignment.topCenter,
      backgroundColor: UiColor.error,
      context,
      duration: UiDuration.toast,
      iconColor: Colors.white,
      message: text,
      textColor: Colors.white,
      width: double.infinity,
    );
  }

  void sucesso({
    required BuildContext context,
    required String text,
  }) {
    toast.successToast(
      alignment: Alignment.topCenter,
      backgroundColor: UiColor.success,
      context,
      duration: UiDuration.toast,
      iconColor: Colors.white,
      message: text,
      textColor: Colors.white,
      width: double.infinity,
    );
  }
}
