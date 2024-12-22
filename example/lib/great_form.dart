import 'package:fancy_form/fancy_form.dart';
import 'package:flutter/services.dart';

class GreatForm extends FancyManager {
  @override
  List<FancyInput> inputs = [
    FancyInput(
      id: 'name',
      rules: (value) => [
        FancyValidator.notEmpty(value),
        () {
          if (value.trim().split(' ').length < 2) {
            return 'Please enter your full name.';
          }
          return null;
        },
      ],
    ),
    FancyInput(
      id: 'fullName',
      rules: (value) => [
        FancyValidator.notEmpty(value),
        FancyValidator.minLength(value, minLength: 3),
      ],
    ),
    FancyInput(
      id: 'phoneNumber',
      mask: '(##) #####-####',
      rules: (value) => [
        FancyValidator.notEmpty(value),
      ],
      keyboardType: TextInputType.phone,
    ),
    FancyInput(
      id: 'address',
      rules: (value) => [
        FancyValidator.notEmpty(value),
      ],
    ),
    FancyInput(
      id: 'notes',
      rules: (value) => [],
    ),
  ];
}
