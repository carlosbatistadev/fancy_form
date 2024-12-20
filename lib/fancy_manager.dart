import 'package:fancy_form/fancy_input.dart';
import 'package:flutter/material.dart';

/// An abstract class that manages the state and validation of a form.
/// It provides methods to handle form inputs, validation, and retrieving controllers by their ID.
abstract class FancyManager {
  /// A global key for the form state, used to manage form validation and submission.
  late GlobalKey<FormState> formKey;

  /// A flag indicating whether the form has been submitted.
  bool hasBeenSubmitted = false;

  /// Creates a [FancyManager] instance with an optional [formKey].
  /// If no [formKey] is provided, a new [GlobalKey<FormState>] will be created.
  FancyManager({
    GlobalKey<FormState>? formKey,
  }) {
    this.formKey = formKey ?? GlobalKey<FormState>();
  }

  /// Validates the form by checking all input fields.
  /// Sets [hasBeenSubmitted] to true and returns true if the form is valid, otherwise false.
  bool validate() {
    hasBeenSubmitted = true;
    return formKey.currentState?.validate() ?? false;
  }

  /// Sets a new [formKey] to the form manager.
  void setFormKey(GlobalKey<FormState> formKey) {
    this.formKey = formKey;
  }

  /// A list of [FancyInput] instances, representing the inputs in the form.
  /// This list must be implemented by subclasses.
  abstract List<FancyInput> inputs;

  /// Retrieves the [TextEditingController] for the input field with the given [id].
  /// Throws an exception if no input with the given [id] is found.
  ///
  /// [id]: The unique identifier for the input field.
  TextEditingController controllerFromId(String id) {
    final input = inputs.where((e) => e.id == id).firstOrNull;

    if (input == null) {
      throw Exception('[FormManager] Invalid form input id ($id)');
    }

    return input.controller;
  }

  /// Retrieves the text entered in the input field with the given [id].
  /// Throws an exception if no input with the given [id] is found.
  ///
  /// [id]: The unique identifier for the input field.
  String getText(String id) {
    final controller = controllerFromId(id);
    return controller.text;
  }

  /// Retrieves the [FancyInput] instance associated with the input field with the given [id].
  /// Throws an exception if no input with the given [id] is found.
  ///
  /// [id]: The unique identifier for the input field.
  FancyInput getInput(String id) {
    final input = inputs.where((e) => e.id == id).firstOrNull;
    if (input == null) {
      throw Exception('[FormManager] Invalid form input id ($id)');
    }
    return input;
  }

  /// Disposes of all input controllers, releasing their resources.
  void dispose() {
    for (final input in inputs) {
      input.controller.dispose();
    }
  }
}
