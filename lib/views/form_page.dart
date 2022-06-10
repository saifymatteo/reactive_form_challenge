import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_form_challenge/utils/constants/text.dart';
import 'package:reactive_form_challenge/utils/helper/form_class.dart';
import 'package:reactive_form_challenge/views/components/radio_list_tile.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // For password show button
  bool obscurePass = true;
  bool obscurePassCon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          // Set the form section
          child: ReactiveForm(
            formGroup: FormClass.form,
            // Set consumer at top level for Sign Up button and the rest
            child: ReactiveFormConsumer(
              builder: (context, formGroup, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          // Sign Up header
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 30),
                            child: Text(
                              AppText.signUp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Name section
                          ReactiveTextField<String>(
                            formControlName: 'name',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validationMessages: (control) => {
                              ValidationMessage.required: FormClass.nameEmpty
                            },
                            decoration: textFieldDecoration(
                              hintText: 'Name',
                              icon: Icons.person,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Email section
                          ReactiveTextField<String>(
                            formControlName: 'email',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validationMessages: (control) => {
                              ValidationMessage.required: FormClass.emailEmpty,
                              ValidationMessage.email: FormClass.emailValid,
                            },
                            decoration: textFieldDecoration(
                              hintText: 'Email',
                              icon: Icons.email,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Password section
                          ReactiveTextField<String>(
                            formControlName: 'password',
                            obscureText: obscurePass,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            validationMessages: (control) => {
                              ValidationMessage.required: FormClass.passEmpty,
                              ValidationMessage.minLength: FormClass.passMinLen,
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
                              ValidationMessage.required:
                                  FormClass.passConEmpty,
                              ValidationMessage.mustMatch:
                                  FormClass.passConMatch,
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

                          // Date of Birth section button
                          ReactiveDatePicker<DateTime>(
                            formControlName: 'dateBirth',
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            keyboardType: TextInputType.datetime,
                            builder: (context, picker, child) {
                              // Set the suffix
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

                              // In case no value set, change suffix
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
                                  dateTimeFormat: DateFormat('dd MMMM yyyy'),
                                ),
                                formControlName: 'dateBirth',
                                readOnly: true,
                                validationMessages: (control) => {
                                  ValidationMessage.required:
                                      FormClass.dateEmpty,
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

                          // Radio button section
                          const ReacRadioListTile(
                            title: 'Flutter is great!',
                            choice: RadioChoice.great,
                          ),
                          const ReacRadioListTile(
                            title: 'Flutter is awesome!',
                            choice: RadioChoice.awesome,
                          ),
                          const ReacRadioListTile(
                            title: 'Other:',
                            choice: RadioChoice.other,
                          ),
                          const SizedBox(height: 20),

                          // Using [Visibility] to hide 'Other' form
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
                              AppText.newsletter,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Big Sign Up button below with simple check
                    ElevatedButton(
                      onPressed: !formGroup.valid
                          ? null
                          : () {
                              // Variables for dialog
                              final name = formGroup.controls['name']!.value;
                              final email = formGroup.controls['email']!.value;
                              final password =
                                  formGroup.controls['password']!.value;
                              final date = DateFormat('dd MMMM yyyy').format(
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
                                        title: Text(
                                          choiceOther == null
                                              ? 'Empty'
                                              : choiceOther.toString(),
                                        ),
                                        leading: const Icon(Icons.text_fields),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        title: Text(
                                          (newsletter! as bool)
                                              ? 'Accept'
                                              : 'Decline',
                                        ),
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
                      child: const Text(AppText.signUp),
                    ),

                    // Small forgot password button below
                    TextButton(
                      onPressed: () {},
                      child: const Text(AppText.forgotPassword),
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

  // Dynamic [InputDecoration] method
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
