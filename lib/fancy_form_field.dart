import 'package:fancy_form/fancy_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FancyFormField extends StatefulWidget {
  final AutovalidateMode? autovalidateMode;
  final FancyKey fancyKey;
  final TextEditingController? controller;
  final bool? enabled;
  final String? forceErrorText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final String? restorationId;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final bool onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableIMEPersonalizedLearning;
  final bool? enableInteractiveSelection;
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
