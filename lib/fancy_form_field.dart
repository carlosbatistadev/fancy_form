import 'package:fancy_form/fancy_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// A custom form field widget that integrates with a form manager and offers various configurable input properties.
///
/// The `FancyFormField` widget allows you to customize the behavior and appearance of a text input field,
/// including validation, input formatting, and styling.
class FancyFormField extends StatefulWidget {
  /// Controls the validation and auto-validation mode for the field.
  final AutovalidateMode? autovalidateMode;

  /// A unique key to identify this field in the form.
  final FancyKey fancyKey;

  /// The controller for the text input field.
  final TextEditingController? controller;

  /// Whether the field is enabled or not.
  final bool? enabled;

  /// A forced error message to display instead of the default error messages.
  final String? forceErrorText;

  /// The initial value of the field.
  final String? initialValue;

  /// A callback that is invoked when the field value changes.
  final ValueChanged<String>? onChanged;

  /// A callback that is invoked when the form is saved.
  final FormFieldSetter<String>? onSaved;

  /// The restoration ID used to restore the state of the field.
  final String? restorationId;

  /// A validator function that validates the field input.
  final FormFieldValidator<String>? validator;

  /// A node that can be used to manage the focus state of the input field.
  final FocusNode? focusNode;

  /// The decoration for the input field, such as label, hint, and icon.
  final InputDecoration? decoration;

  /// The keyboard type (e.g., text, number, email).
  final TextInputType? keyboardType;

  /// Controls text capitalization behavior for the field (e.g., none, sentences, words).
  final TextCapitalization textCapitalization;

  /// The action button on the keyboard (e.g., next, done).
  final TextInputAction? textInputAction;

  /// The text style for the input field.
  final TextStyle? style;

  /// The style for the text strut (line height).
  final StrutStyle? strutStyle;

  /// The text direction for the input field (e.g., left-to-right, right-to-left).
  final TextDirection? textDirection;

  /// The alignment of the text within the field (e.g., left, right, center).
  final TextAlign textAlign;

  /// The vertical alignment of the text within the field.
  final TextAlignVertical? textAlignVertical;

  /// Whether the field should autofocus when the widget is built.
  final bool autofocus;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Controls whether the cursor is visible in the field.
  final bool? showCursor;

  /// The character to obscure the text when `obscureText` is enabled (e.g., `•`).
  final String obscuringCharacter;

  /// Whether the field obscures the text (typically used for passwords).
  final bool obscureText;

  /// Whether autocorrection is enabled for the field.
  final bool autocorrect;

  /// A list of input formatters to apply to the input field.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether suggestions (e.g., predictive text) are enabled.
  final bool enableSuggestions;

  /// The maximum number of lines that the input can occupy.
  final int? maxLines;

  /// The minimum number of lines that the input can occupy.
  final int? minLines;

  /// Whether the input should expand to fill the available space.
  final bool expands;

  /// The maximum length of the input.
  final int? maxLength;

  /// A callback that is triggered when the input field is tapped.
  final GestureTapCallback? onTap;

  /// Whether the `onTap` callback should always be called.
  final bool onTapAlwaysCalled;

  /// A callback that is triggered when tapping outside of the field.
  final TapRegionCallback? onTapOutside;

  /// A callback that is triggered when editing is complete.
  final VoidCallback? onEditingComplete;

  /// A callback that is triggered when the field value is submitted.
  final ValueChanged<String>? onFieldSubmitted;

  /// The scroll physics to apply to the field's scrollable area.
  final ScrollPhysics? scrollPhysics;

  /// The controller for the scrollable area of the field.
  final ScrollController? scrollController;

  /// The width of the cursor in the input field.
  final double cursorWidth;

  /// The height of the cursor in the input field.
  final double? cursorHeight;

  /// The radius of the cursor.
  final Radius? cursorRadius;

  /// The color of the cursor in the input field.
  final Color? cursorColor;

  /// The color of the cursor when an error occurs.
  final Color? cursorErrorColor;

  /// The appearance mode of the keyboard (e.g., light or dark).
  final Brightness? keyboardAppearance;

  /// The padding for the scrollable area of the field.
  final EdgeInsets scrollPadding;

  /// Whether to enable personalized learning for the IME (Input Method Editor).
  final bool enableIMEPersonalizedLearning;

  /// Whether to allow interactive selection of the text in the input field.
  final bool? enableInteractiveSelection;

  /// The clipping behavior for the input field.
  final Clip clipBehavior;

  const FancyFormField({
    super.key,
    required this.fancyKey,
    this.autovalidateMode,
    this.controller,
    this.enabled,
    this.forceErrorText,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.restorationId,
    this.validator,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.inputFormatters,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.scrollPhysics,
    this.scrollController,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  State<FancyFormField> createState() => _FancyFormFieldState();
}

/// The state of the `FancyFormField` widget, managing the text input controller and input formatters.
class _FancyFormFieldState extends State<FancyFormField> {
  late final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters = [];
  TextInputType keyboardType = TextInputType.text;

  @override
  void initState() {
    super.initState();
    final formManager = widget.fancyKey.formManager;
    final input = formManager.getInput(widget.fancyKey.id);
    controller = input.controller;
    final formatter = MaskTextInputFormatter(
      mask: input.mask,
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    inputFormatters.add(formatter);
    inputFormatters.addAll(input.inputFormatters ?? []);
    inputFormatters.addAll(widget.inputFormatters ?? []);
    keyboardType =
        input.keyboardType ?? widget.keyboardType ?? TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      controller: controller,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      decoration: widget.decoration,
      keyboardType: keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      inputFormatters: inputFormatters,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      scrollPhysics: widget.scrollPhysics,
      scrollController: widget.scrollController,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      clipBehavior: widget.clipBehavior,
      onSaved: widget.onSaved,
      validator: (value) {
        final formManager = widget.fancyKey.formManager;
        final input = formManager.inputs
            .where(
              (e) => e.id == widget.fancyKey.id,
            )
            .firstOrNull;
        final rules = input?.rules.call(value ?? '') ?? [];

        for (final rule in rules) {
          if (rule() is String) {
            return rule();
          }
          continue;
        }
        return widget.validator?.call(value);
      },
      onChanged: widget.onChanged,
      restorationId: widget.restorationId,
    );
  }
}
