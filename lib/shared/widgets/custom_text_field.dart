import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellcheck/utils/extensions.dart';
import 'package:wellcheck/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.inputFormatters = const [],
    this.obsecure = false,
    this.hint = '',
    this.verticalPadding,
    this.initialText = '',
    this.trailing,
    this.enabled = true,
    this.label,
    this.controller,
    this.textDirection,
    this.max,
    this.showRequiredSign = false,
    this.hideCounter = true,
    this.textAlign,
    this.prefixIcon,
  });

  final Function(String) onChanged;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool enabled;
  final TextInputAction inputAction;
  final List<TextInputFormatter> inputFormatters;
  final bool obsecure;
  final String hint;
  final int? max;
  final bool hideCounter;
  final String? label;
  final String initialText;
  final Widget? prefixIcon;
  final double? verticalPadding;
  final TextDirection? textDirection;
  final bool showRequiredSign;
  final TextAlign? textAlign;
  final Widget? trailing;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController? textController;

  @override
  void initState() {
    textController =
        widget.controller ?? TextEditingController(text: widget.initialText);
    super.initState();
  }

  // @override
  // void dispose() {
  //   textController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.label != null && widget.label!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12, right: 2),
                child: Text(
                  widget.label!,
                  style: context.textTheme().bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            if (widget.showRequiredSign)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '*',
                  style: context.textTheme().bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Styles.mainRed,
                      ),
                ),
              ),
          ],
        ),
        TextField(
          onChanged: widget.onChanged,
          textAlign: widget.textAlign ?? TextAlign.start,
          enabled: widget.enabled,
          controller: textController,
          autocorrect: false,
          obscureText: widget.obsecure,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          inputFormatters: widget.inputFormatters,
          style: Styles.bodyMedium,
          maxLength: widget.max,
          buildCounter: !widget.hideCounter
              ? null
              : (context,
                      {required currentLength,
                      required isFocused,
                      required maxLength}) =>
                  const SizedBox.shrink(),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.trailing,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Styles.mainGrey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Styles.mainGrey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                width: 0.8,
                color: Styles.mainPurple,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
