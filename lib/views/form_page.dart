import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum RadioChoice { great, awesome, other }

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final form = FormGroup(
    {
      'name': FormControl<String>(
        value: 'Das',
        validators: [Validators.required],
      ),
      'email': FormControl<String>(
        value: 'Das@mail.com',
        validators: [Validators.email, Validators.required],
      ),
      'password': FormControl<String>(
        value: '12345678',
        validators: [Validators.required, Validators.minLength(8)],
      ),
      'passwordConfirm': FormControl<String>(
        value: '12345678',
        validators: [Validators.required],
      ),
      'dateBirth': FormControl<DateTime>(
        validators: [Validators.required],
      ),
      'answer': FormControl<RadioChoice>(
        validators: [Validators.required],
      ),
      'answerOther': FormControl<String>(),
      'newsletter': FormControl<bool>(
        value: true,
      ),
    },
    validators: [
      Validators.mustMatch('password', 'passwordConfirm'),
    ],
  );

  bool obscurePass = true;
  bool obscurePassCon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ReactiveForm(
            formGroup: form,
            child: ReactiveFormConsumer(
              builder: (context, formGroup, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 30),
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ReactiveTextField<String>(
                            formControlName: 'name',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  'Name must not be empty',
                            },
                            decoration: textFieldDecoration(
                              hintText: 'Name',
                              icon: Icons.person,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ReactiveTextField<String>(
                            formControlName: 'email',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  'Email must not be empty',
                              ValidationMessage.email: 'Email must be valid',
                            },
                            decoration: textFieldDecoration(
                              hintText: 'Email',
                              icon: Icons.email,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ReactiveTextField<String>(
                            formControlName: 'password',
                            obscureText: obscurePass,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  'Password must not be empty',
                              ValidationMessage.minLength:
                                  'Password must be higher than 8 characters',
                            },
                            decoration: textFieldDecoration(
                              hintText: 'Password',
                              icon: Icons.key,
                              suffix: Material(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      obscurePass = !obscurePass;
                                    });
                                  },
                                  child: const Text(
                                    'Show',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ReactiveTextField<String>(
                            formControlName: 'passwordConfirm',
                            obscureText: obscurePassCon,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            validationMessages: (control) => {
                              ValidationMessage.required: 'Must not be empty',
                              ValidationMessage.mustMatch: 'Password not match'
                            },
                            decoration: textFieldDecoration(
                              hintText: 'Password again',
                              icon: Icons.vpn_key,
                              suffix: Material(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      obscurePassCon = !obscurePassCon;
                                    });
                                  },
                                  child: const Text(
                                    'Show',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ReactiveDatePicker<DateTime>(
                            formControlName: 'dateBirth',
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            keyboardType: TextInputType.datetime,
                            builder: (context, picker, child) {
                              Widget suffix = Material(
                                child: InkWell(
                                  onTap: () {
                                    picker.control.value = null;
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.green,
                                  ),
                                ),
                              );

                              if (picker.value == null) {
                                suffix = const Icon(
                                  Icons.calendar_today,
                                  color: Colors.green,
                                );
                              }

                              return ReactiveTextField<DateTime>(
                                onTap: () {
                                  picker.showPicker();
                                },
                                valueAccessor: DateTimeValueAccessor(
                                  dateTimeFormat: DateFormat('dd MMM yyyy'),
                                ),
                                formControlName: 'dateBirth',
                                readOnly: true,
                                validationMessages: (control) => {
                                  ValidationMessage.required:
                                      'Date of birth must not be empty'
                                },
                                decoration: textFieldDecoration(
                                  hintText: 'Date of Birth',
                                  icon: Icons.calendar_month,
                                  suffix: suffix,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const RadioListTile(
                            title: 'Flutter is great!',
                            choice: RadioChoice.great,
                          ),
                          const RadioListTile(
                            title: 'Flutter is awesome!',
                            choice: RadioChoice.awesome,
                          ),
                          const RadioListTile(
                            title: 'Other:',
                            choice: RadioChoice.other,
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: formGroup.controls['answer']!.value ==
                                RadioChoice.other,
                            child: ReactiveTextField<String>(
                              formControlName: 'answerOther',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: textFieldDecoration(
                                hintText: 'Other',
                                icon: Icons.text_fields,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ReactiveCheckboxListTile(
                            formControlName: 'newsletter',
                            title: const Text(
                              'I would like to receive your newsletter and other promotional information',
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: !formGroup.valid
                          ? null
                          : () {
                              // Variables for dialog
                              final name = formGroup.controls['name']!.value;
                              final email = formGroup.controls['email']!.value;
                              final password =
                                  formGroup.controls['password']!.value;
                              final date = DateFormat('dd MMM yyyy').format(
                                formGroup.controls['dateBirth']!.value!
                                    as DateTime,
                              );
                              final choice =
                                  formGroup.controls['answer']!.value;
                              final choiceOther =
                                  formGroup.controls['answerOther']!.value;
                              final newsletter =
                                  formGroup.controls['newsletter']!.value;

                              // Show the dialog
                              showDialog<String>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Your Input'),
                                  scrollable: true,
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(name.toString()),
                                        leading: const Icon(Icons.person),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(email.toString()),
                                        leading: const Icon(Icons.email),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(password.toString()),
                                        leading: const Icon(Icons.key),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(date),
                                        leading: const Icon(
                                          Icons.calendar_month,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(choice.toString()),
                                        leading: const Icon(
                                          Icons.radio_button_checked,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(choiceOther.toString()),
                                        leading: const Icon(Icons.text_fields),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(newsletter.toString()),
                                        leading: const Icon(Icons.newspaper),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot your password?'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration({
    String? hintText,
    IconData? icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hintText,
      label: icon == null ? null : Icon(icon),
      filled: true,
      isCollapsed: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      suffix: suffix,
    );
  }
}

class RadioListTile extends StatelessWidget {
  const RadioListTile({
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
