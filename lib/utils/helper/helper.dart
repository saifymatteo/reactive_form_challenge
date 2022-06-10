import 'package:reactive_forms/reactive_forms.dart';

// Simple and accurate date checker function
//
// Function to calculate [DateTime] with [ReactiveForm]
//
// Taken from [@bryanjorgeflores](https://github.com/joanpablo/reactive_forms/issues/175)
Map<String, dynamic>? calculateAge(AbstractControl<dynamic> control) {
  // Set message
  final message = {'Must be over 18 years old': false};

  // Get current time
  final currentDate = DateTime.now();

  // Check for [null] on [control]
  if (control.value != null) {
    // Set [selectedDate] to [DateTime] from [ReactiveForm]
    final selectedDate = control.value as DateTime;

    // Get difference of years from [currentDate] and [selectedDate]
    var age = currentDate.year - selectedDate.year;

    // Set months from [currentDate] and [selectedDate]
    final curMonth = currentDate.month;
    final selMonth = selectedDate.month;

    // Check for month
    if (selMonth > curMonth) {
      age--;
    }
    // If month equals
    else if (curMonth == selMonth) {
      // Set day from [currentDate] and [selectedDate]
      final curDay = currentDate.day;
      final selDay = selectedDate.day;

      // Check for day
      if (selDay > curDay) {
        age--;
      }
    }
    // Check for [age] below 18
    if (age < 18) {
      return message;
    }
  }

  return null;
}
