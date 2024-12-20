# Fancy Form

A flexible and easy-to-use form management solution for Flutter. The `fancy_form` package simplifies form validation and management with customizable input rules and automatic validation handling. It offers reusable components and a structured way to manage forms across your Flutter apps.

## Features

- **Built-in Validators**: Use predefined validators like `notEmpty`, `minLength`, `validEmail`, etc.
- **Input Masking**: Supports input masks for fields like phone numbers.
- **Easy Integration**: Manage forms with `FancyManager`.
- **State Management**: Automatic validation and form state management.
- **Custom Input Fields**: Create your own form inputs with rules and masks.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  fancy_form: ^1.0.0+2
```

Run `flutter pub get` to install.

## Usage
### 1. Create a Form Manager
Define a form manager by extending `FancyManager`. It handles the inputs and validation.

```dart
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
      id: 'phoneNumber',
      mask: '(##) #####-####',
      rules: (value) => [FancyValidator.notEmpty(value)],
      keyboardType: TextInputType.phone,
    ),
  ];
}
```
### 2. Create the Form UI
Use `FancyForm` and `FancyFormField` to display and manage the form inputs.

```dart
import 'package:fancy_form/fancy_form.dart';
import 'package:flutter/material.dart';

class SimpleFormScreen extends StatefulWidget {
  const SimpleFormScreen({super.key});

  @override
  State<SimpleFormScreen> createState() => _SimpleFormScreenState();
}

class _SimpleFormScreenState extends State<SimpleFormScreen> {
  final greatForm = GreatForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FancyForm(
          fancyManager: greatForm,
          child: ListView(
            children: [
              FancyFormField(
                fancyKey: FancyKey(id: 'name', formManager: greatForm),
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              FancyFormField(
                fancyKey: FancyKey(id: 'phoneNumber', formManager: greatForm),
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              FilledButton(
                onPressed: () {
                  if (greatForm.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Form validated successfully'),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 3. Form Validation
To validate the form:

```dart
bool isValid = greatForm.validate();
if (isValid) {
  // Form is valid, proceed with submission
} else {
  // Handle invalid form
}
```

### 4. Accessing Input Values
You can retrieve the value of any input field using `getText(id)` or by using the controller:

```dart
String name = greatForm.getText('name');
```

### 5. Disposing of Form Resources
Dispose of the form when not in use:

```dart
greatForm.dispose();
```

## Custom Validators
In addition to built-in validators like `notEmpty`, `minLength`, `validEmail`, and `validCPF`, you can create custom validation functions within the rules for each `FancyInput`. Simply define a function that checks a condition and returns an error message if validation fails.

### Example:
Custom validation to ensure the input contains at least two words:

```dart
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
)
```

## Contributions

Contributions are welcome! If you want to contribute to this project, please follow these steps:

1. **Fork this repository.**
2. **Create a new branch for your modification.**
3. **Make your changes and submit a pull request.**

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.