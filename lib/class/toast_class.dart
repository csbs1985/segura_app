import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_duration.dart';

class ToastClass {
  ShowMToast toast = ShowMToast();

  void erro({
    required BuildContext context,
    required String texto,
  }) {
    toast.errorToast(
      alignment: Alignment.topCenter,
      backgroundColor: UiColor.error,
      context,
      duration: UiDuration.toast,
      iconColor: Theme.of(context).iconTheme.color,
      message: texto,
      textColor: Theme.of(context).iconTheme.color,
      width: double.infinity,
    );
  }

  void sucesso({
    required BuildContext context,
    required String texto,
  }) {
    toast.successToast(
      alignment: Alignment.topCenter,
      backgroundColor: UiColor.success,
      context,
      duration: UiDuration.toast,
      iconColor: Theme.of(context).iconTheme.color,
      message: texto,
      textColor: Theme.of(context).iconTheme.color,
      width: double.infinity,
    );
  }
}
