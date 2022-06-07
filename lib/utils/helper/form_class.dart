import 'package:reactive_form_challenge/utils/helper/helper.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum RadioChoice { great, awesome, other }

class FormClass {
  static const nameEmpty = 'Name must not be empty';
  static const emailEmpty = 'Email must not be empty';
  static const emailValid = 'Email must be valid';
  static const passEmpty = 'Password must not be empty';
  static const passMinLen = 'Password must be higher than 8 characters';
  static const passConEmpty = 'Must not be empty';
  static const passConMatch = 'Password not match';
  static const dateEmpty = 'Date of birth must not be empty';

  // For password pattern
  static const validateUppercase = '(?=.*?[A-Z])';
  static const validateLowercase = '(?=.*?[a-z])';
  static const validateNumber = '(?=.*?[0-9])';
  static const validateSymbol = r'(?=.*?[#?!@$%^&*-])';
  static const validatePassText = 'Must contain a single';

  //
  static final form = FormGroup(
    {
      'name': FormControl<String>(
        value: 'Das',
        validators: [Validators.required],
        touched: true,
      ),
      'email': FormControl<String>(
        value: 'Das@mail.com',
        validators: [Validators.email, Validators.required],
        touched: true,
      ),
      'password': FormControl<String>(
        value: '12345678Ss@',
        validators: [
          Validators.required,
          Validators.minLength(8),
          Validators.pattern(
            validateUppercase,
            validationMessage: '$validatePassText uppercase letter',
          ),
          Validators.pattern(
            validateLowercase,
            validationMessage: '$validatePassText lowercase letter',
          ),
          Validators.pattern(
            validateNumber,
            validationMessage: '$validatePassText number',
          ),
          Validators.pattern(
            validateSymbol,
            validationMessage: '$validatePassText symbol',
          ),
        ],
        touched: true,
      ),
      'passwordConfirm': FormControl<String>(
        value: '12345678Ss@',
        validators: [Validators.required],
        touched: true,
      ),
      'dateBirth': FormControl<DateTime>(
        value: DateTime(2004, 6, 7),
        validators: [
          Validators.required,
          calculateAge,
        ],
        touched: true,
      ),
      'answer': FormControl<RadioChoice>(
        validators: [Validators.required],
        touched: true,
      ),
      'answerOther': FormControl<String>(
        validators: [
          // TODO(saifymatteo): Need to check whether [RadioChoice.other] is selected in here.
          // Validators.compare('answer', 'answerOther', CompareOption.equal),
        ],
        touched: true,
      ),
      'newsletter': FormControl<bool>(
        value: true,
        touched: true,
      ),
    },
    validators: [
      Validators.mustMatch('password', 'passwordConfirm'),
    ],
  );
}
