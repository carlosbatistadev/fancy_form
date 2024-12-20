# Fancy Form

A flexible and easy-to-use form management solution for Flutter. The `fancy_form` package simplifies form validation and management with customizable input rules and automatic validation handling. It offers reusable components and a structured way to manage forms across your Flutter apps.

## Features

- **Custom Validation**: Use predefined validators like `notEmpty`, `minLength`, `validEmail`, and more.
- **Input Masking**: Supports input masks for fields like phone numbers.
- **Easy Integration**: Manage forms with the `FancyManager` and create dynamic forms easily.
- **State Management**: Automatic form validation and state management with `FancyManager`.
- **Custom Input Fields**: Define custom form inputs with validation rules and masks.

## Installation

To use this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  fancy_form: ^1.0.0
```

Then, run `flutter pub get` to install the dependencies.

## Usage
1. Create a Form Manager
To manage your form, create a class that extends FancyManager. This class will handle the form inputs, validation rules, and controllers.

dart
Copiar código
