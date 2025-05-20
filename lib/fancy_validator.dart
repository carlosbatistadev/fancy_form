/// A utility class providing static methods to create validation functions for form fields.
///
/// The validation functions return an error message if the input value does not satisfy the validation rule,
/// or `null` if the input is valid.
class FancyValidator {
  /// Private constructor to prevent instantiation of this utility class.
  FancyValidator._();

  /// Returns a validation function that checks if the input value is not empty.
  ///
  /// The validation function will return an error message if the value is empty,
  /// otherwise it returns `null` indicating the value is valid.
  ///
  /// [value]: The input value to validate.
  /// [errorMessage]: The error message to display if the validation fails. If not provided, a default message is used.
  static String? Function() notEmpty(
    String value, {
    String? errorMessage,
  }) {
    return () {
      if (value.isEmpty) {
        return errorMessage ?? 'This field is required.';
      }
      return null;
    };
  }

  /// Returns a validation function that checks if the input value is a valid email address.
  ///
  /// The validation function will return an error message if the value does not match the email regex pattern,
  /// otherwise it returns `null` indicating the value is valid.
  ///
  /// [value]: The input value to validate.
  /// [errorMessage]: The error message to display if the validation fails. If not provided, a default message is used.
  static String? Function() validEmail(
    String value, {
    String? errorMessage,
  }) {
    return () {
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      if (!emailRegex.hasMatch(value)) {
        return errorMessage ?? 'Please enter a valid email address.';
      }
      return null;
    };
  }

  /// Returns a validation function that checks if the input value meets a minimum length requirement.
  ///
  /// The validation function will return an error message if the value's length is less than the specified [minLength],
  /// otherwise it returns `null` indicating the value is valid.
  ///
  /// [value]: The input value to validate.
  /// [errorMessage]: The error message to display if the validation fails. If not provided, a default message is used.
  /// [minLength]: The minimum required length for the input value. The default is 8.
  static String? Function() minLength(
    String value, {
    String? errorMessage,
    int minLength = 8,
  }) {
    return () {
      if (value.length < minLength) {
        return errorMessage ?? 'Please enter at least $minLength characters.';
      }
      return null;
    };
  }

  /// Returns a validation function that checks if the input value is a valid CPF (Brazilian individual taxpayer registry).
  ///
  /// The validation function will return an error message if the value does not meet the CPF format or fails the CPF check,
  /// otherwise it returns `null` indicating the value is valid.
  ///
  /// [value]: The input value to validate.
  /// [errorMessage]: The error message to display if the validation fails. If not provided, a default message is used.
  static String? Function() validCPF(
    String value, {
    String? errorMessage,
  }) {
    return () {
      String cpf = value.replaceAll(RegExp(r'\D'), '');

      if (cpf.length != 11 ||
          !RegExp(r'^\d{11}$').hasMatch(cpf) ||
          RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
        return errorMessage ?? 'Please enter a valid CPF.';
      }

      int sum1 = 0;
      for (int i = 0; i < 9; i++) {
        sum1 += int.parse(cpf[i]) * (10 - i);
      }
      int digit1 = (sum1 * 10) % 11;
      if (digit1 == 10) digit1 = 0;

      int sum2 = 0;
      for (int i = 0; i < 10; i++) {
        sum2 += int.parse(cpf[i]) * (11 - i);
      }
      int digit2 = (sum2 * 10) % 11;
      if (digit2 == 10) digit2 = 0;

      if (digit1 != int.parse(cpf[9]) || digit2 != int.parse(cpf[10])) {
        return errorMessage ?? 'Please enter a valid CPF.';
      }

      return null;
    };
  }

  /// Returns a validation function that checks if the input value is a valid CNPJ (Brazilian company taxpayer registry).
  ///
  /// The validation function will return an error message if the value does not meet the CNPJ format or fails the CNPJ check,
  /// otherwise it returns `null` indicating the value is valid.
  ///
  /// [value]: The input value to validate.
  /// [errorMessage]: The error message to display if the validation fails. If not provided, a default message is used.
  static String? Function() validCNPJ(
    String value, {
    String? errorMessage,
  }) {
    return () {
      String cnpj = value.replaceAll(RegExp(r'\D'), '');

      if (cnpj.length != 14 ||
          !RegExp(r'^\d{14}$').hasMatch(cnpj) ||
          RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
        return errorMessage ?? 'Please enter a valid CNPJ.';
      }

      List<int> weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
      List<int> weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

      int sum1 = 0;
      for (int i = 0; i < 12; i++) {
        sum1 += int.parse(cnpj[i]) * weights1[i];
      }
      int digit1 = (sum1 * 10) % 11;
      if (digit1 == 10) digit1 = 0;

      int sum2 = 0;
      for (int i = 0; i < 13; i++) {
        sum2 += int.parse(cnpj[i]) * weights2[i];
      }
      int digit2 = (sum2 * 10) % 11;
      if (digit2 == 10) digit2 = 0;

      if (digit1 != int.parse(cnpj[12]) || digit2 != int.parse(cnpj[13])) {
        return errorMessage ?? 'Please enter a valid CNPJ.';
      }

      return null;
    };
  }

  /// Returns a validation function that applies a custom validation rule.
  ///
  /// The validation function will apply the provided custom validation function to the input value.
  ///
  /// [value]: The input value to validate.
  /// [validator]: The custom validation function that defines the validation logic.
  /// Returns null if valid, or an error message string if invalid.
  static String? Function() validField(
    String value,
    String? Function(String) validator,
  ) {
    return () {
      return validator(value);
    };
  }
}
