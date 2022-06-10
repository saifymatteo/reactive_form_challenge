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
        validators: [Validators.required],
      ),
      'email': FormControl<String>(
        validators: [Validators.email, Validators.required],
      ),
      'password': FormControl<String>(
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
      ),
      'passwordConfirm': FormControl<String>(
        validators: [Validators.required],
      ),
      'dateBirth': FormControl<DateTime>(
        validators: [
          Validators.required,
          calculateAge,
        ],
      ),
      'answer': FormControl<RadioChoice>(
        validators: [Validators.required],
      ),
      'answerOther': FormControl<String>(
        // TODO(saifymatteo): Need to check whether [RadioChoice.other] is selected in here.
        // validators: [],
      ),
      'newsletter': FormControl<bool>(),
    },
    validators: [
      Validators.mustMatch('password', 'passwordConfirm'),
    ],
  );
}
