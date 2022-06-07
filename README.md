# Reactive Form Challenge

This project is a challenge project for [Flutter Challenge](https://flutterchallenge.dev/validate-your-input).

The challenge is to implements a signup form with proper validations by using [reactive_forms](https://pub.dev/packages/reactive_forms) package.

The form design is [here](https://www.figma.com/file/8XSUHjGY26hip1XU6bEks3/June-Challenge?node-id=223%3A1910)

## Validation Rules

- ✅ All fields are mandatory
- ✅ Email must be in the right format
- ✅ Password must be at least 8 characters long and must contain at least a lowercase, an uppercase letter, a number and a symbol.
- ✅ Password and Password again must match
- ✅ The user must be the age 18 or above to be able to sign up.
- If the user selects the other option, the Other field must be filled out as well.
- ✅ The submit button is enabled only if the form is valid

If the form is valid the user is redirected to the login page.

## Build

To build the app, simply run in the terminal:

``` cmd
flutter build
```

### Requirements

- Flutter: ```3.0.1```
- Dart: ```2.17.0```
