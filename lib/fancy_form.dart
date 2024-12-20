library;

export 'fancy_form_field.dart';
export 'fancy_input.dart';
export 'fancy_manager.dart';
export 'fancy_validator.dart';

import 'package:fancy_form/fancy_manager.dart';
import 'package:flutter/widgets.dart';

/// A widget that wraps the form content with validation and management features.
class FancyForm extends StatefulWidget {
  /// The manager responsible for handling form state and input validation.
  final FancyManager fancyManager;

  /// The mode for auto-validating the form fields.
  final AutovalidateMode? autovalidateMode;

  /// The child widget that represents the content of the form.
  final Widget child;

  /// Creates a [FancyForm] widget.
  const FancyForm({
    super.key,
    required this.child,
    required this.fancyManager,
    this.autovalidateMode,
  });

  @override
  State<FancyForm> createState() => _FancyFormState();
}

class _FancyFormState extends State<FancyForm> {
  /// The key that uniquely identifies the form in the widget tree.
  late final GlobalKey<FormState> _formKey;

  /// The auto-validation mode for the form fields.
  AutovalidateMode? autovalidateMode;

  @override
  void initState() {
    super.initState();
    // Initialize the form key and set it in the [fancyManager].
    _formKey = GlobalKey<FormState>();
    widget.fancyManager.setFormKey(_formKey);
    autovalidateMode = widget.autovalidateMode;
  }

  @override
  void dispose() {
    // Dispose of the form state when the widget is removed.
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Form(
        // The global form key that allows validation and saving form data.
        key: _formKey,
        onChanged: () {
          // Auto-validate the form after submission or user interaction.
          if (autovalidateMode == null &&
              widget.fancyManager.hasBeenSubmitted) {
            setState(() {
              autovalidateMode = AutovalidateMode.onUserInteraction;
            });
          }
        },
        // Set the autovalidate mode for the form.
        autovalidateMode: autovalidateMode,
        child: widget.child,
      );
    });
  }
}
