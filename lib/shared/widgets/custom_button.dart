import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellcheck/utils/styles.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({
    super.key,
    required this.onTap,
    required this.label,
    this.enabled,
    this.leading,
    this.prefix,
    this.background = Styles.mainPurple,
    this.fontSize,
    this.labelColor = Colors.white,
    this.verticalPadding,
    this.fontWeight,
    this.disabledColor,
    this.horizontalPadding,
    this.disabledTextColor,
    this.iconPadding,
    this.animateLoadingState = false,
    this.radius,
  });

  final Function() onTap;
  final bool? enabled;
  final String label;
  final Widget? leading;
  final Widget? prefix;

  final FontWeight? fontWeight;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final double? iconPadding;
  final double? fontSize;
  final bool animateLoadingState;
  final Color background;
  final Color labelColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? radius;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool loading = false;

  @override
  void didUpdateWidget(covariant RoundedButton oldWidget) {
    if (oldWidget.enabled != widget.enabled && mounted) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 100),
        color: widget.enabled == false ? Styles.mainGrey : Styles.mainPurple,
      ),
      child: TextButton(
        onPressed: widget.enabled == null || widget.enabled!
            ? () async {
                if (widget.animateLoadingState == false) {
                  widget.onTap();
                } else {
                  if (loading) return;
                  loading = true;
                  setState(() {});
                  try {
                    await widget.onTap();
                  } on Exception catch (_) {
                    rethrow;
                  } finally {
                    loading = false;
                    setState(() {});
                  }
                }
              }
            : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.resolveWith((states) => EdgeInsets.zero),
          backgroundColor:
              WidgetStateProperty.resolveWith((states) => Colors.transparent),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 100),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding ?? 12,
            horizontal: widget.horizontalPadding ?? 22,
          ),
          child: SizedBox(
            child: AnimatedSizeAndFade(
              child: (widget.animateLoadingState && loading)
                  ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 20,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.leading != null) widget.leading!,
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Text(
                              widget.label,
                              style: TextStyle(
                                color: widget.enabled == false
                                    ? widget.disabledTextColor ??
                                        widget.labelColor
                                    : widget.labelColor,
                                fontWeight:
                                    widget.fontWeight ?? FontWeight.w700,
                                fontSize: widget.fontSize ?? 16,
                              ),
                            ),
                          ),
                        ),
                        if (widget.prefix != null) widget.prefix!,
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
