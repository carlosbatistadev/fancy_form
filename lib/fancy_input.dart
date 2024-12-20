import 'package:fancy_form/fancy_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A class that represents a key used to reference a form field in a [FancyManager].
/// Each [FancyKey] associates a unique identifier with a [FancyManager] instance.
class FancyKey {
  /// The unique identifier for this key, used to reference a specific form field.
  final String id;

  /// The manager responsible for managing the form state and validation logic.
  final FancyManager formManager;

  /// Creates a [FancyKey] instance with a given [id] and [formManager].
  FancyKey({
    required this.id,
    required this.formManager,
  });
}

/// A class that represents an input field with validation rules and other properties.
class FancyInput {
  /// The unique identifier for this input field.
  final String id;

  /// A function that returns a list of validation rules for the input field.
  /// Each rule is a function that returns either a string error message or null.
  final List<String? Function()> Function(String value) rules;

  /// The controller that manages the text being edited in this input field.
  late final TextEditingController controller;

  /// A mask for the input field, used to format the entered text (e.g., phone number).
  final String? mask;

  /// The keyboard type to use for this input field (e.g., numeric, email).
  final TextInputType? keyboardType;

  /// A list of input formatters that can be applied to the text input (e.g., for custom formatting).
  final List<TextInputFormatter>? inputFormatters;

  /// Creates a [FancyInput] instance with the provided properties.
  /// If no [controller] is provided, a new [TextEditingController] is created.
  FancyInput({
    required this.id,
    required this.rules,
    TextEditingController? controller,
    this.mask,
    this.keyboardType,
    this.inputFormatters,
  }) {
    // Initialize the controller, either from the provided one or create a new instance.
    this.controller = controller ?? TextEditingController();
  }
}
