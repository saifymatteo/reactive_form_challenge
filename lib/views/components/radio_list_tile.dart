import 'package:flutter/material.dart';
import 'package:reactive_form_challenge/utils/helper/form_class.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReacRadioListTile extends StatelessWidget {
  const ReacRadioListTile({
    super.key,
    this.choice,
    this.title,
  });

  final RadioChoice? choice;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ReactiveRadioListTile(
      formControlName: 'answer',
      value: choice,
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
