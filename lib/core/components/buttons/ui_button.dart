import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

import '../../core.dart';

class UiButton extends StatefulWidget {
  const UiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabledOnPressed,
    this.labelAlign,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.labelColor,
    this.disabledBackgroundColor,
    this.disabledLabelColor = UiColors.textWhite,
    this.isDisabled = false,
    this.isLoading = false,
    this.style,
    this.height = 56,
    this.width,
    this.showAnimatedBorder = false,
    this.gradientColors = UiColors.gradientPrimary,
    this.borderRadius = 8.0,
    this.gradientAnimationDuration = const Duration(seconds: 1),
  });

  const UiButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabledOnPressed,
    this.labelAlign,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor = UiColors.bgSoft,
    this.borderColor,
    this.shadowColor,
    this.labelColor = UiColors.textDarker,
    this.disabledBackgroundColor = UiColors.bgSoft,
    this.disabledLabelColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.style,
    this.height = 56,
    this.width,
    this.showAnimatedBorder = false,
    this.gradientColors = UiColors.gradientPrimary,
    this.borderRadius = 8.0,
    this.gradientAnimationDuration = const Duration(seconds: 1),
  });

  const UiButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabledOnPressed,
    this.labelAlign,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor = UiColors.bgWhite,
    this.borderColor = UiColors.strokeMuted,
    this.shadowColor,
    this.labelColor = UiColors.textDarker,
    this.disabledBackgroundColor,
    this.disabledLabelColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.style,
    this.height = 56,
    this.width,
    this.showAnimatedBorder = false,
    this.gradientColors = UiColors.gradientPrimary,
    this.borderRadius = 8.0,
    this.gradientAnimationDuration = const Duration(seconds: 1),
  });

  const UiButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabledOnPressed,
    this.labelAlign,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor = UiColors.dangerMain,
    this.borderColor,
    this.shadowColor,
    this.labelColor,
    this.disabledBackgroundColor,
    this.disabledLabelColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.style,
    this.height = 56,
    this.width,
    this.showAnimatedBorder = false,
    this.gradientColors = UiColors.gradientPrimary,
    this.borderRadius = 8.0,
    this.gradientAnimationDuration = const Duration(seconds: 1),
  });

  const UiButton.success({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabledOnPressed,
    this.labelAlign,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor = UiColors.successMain,
    this.borderColor,
    this.shadowColor,
    this.labelColor,
    this.disabledBackgroundColor,
    this.disabledLabelColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.style,
    this.height = 56,
    this.width,
    this.showAnimatedBorder = false,
    this.gradientColors = UiColors.gradientPrimary,
    this.borderRadius = 8.0,
    this.gradientAnimationDuration = const Duration(seconds: 1),
  });

  final String label;
  final VoidCallback onPressed;
  final VoidCallback? disabledOnPressed;
  final Alignment? labelAlign;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final Color? labelColor;
  final Color? disabledBackgroundColor;
  final Color? disabledLabelColor;
  final bool isDisabled;
  final bool isLoading;
  final ButtonStyle? style;
  final double height;
  final double? width;
  final bool? showAnimatedBorder;
  final List<Color> gradientColors;
  final double borderRadius;
  final Duration gradientAnimationDuration;

  Widget buildIcon(dynamic icon, EdgeInsets padding, Color color) {
    if (icon == null) return const SizedBox();
    if (icon is IconData) {
      return Icon(icon, color: color).addPadding(padding);
    }
    if (icon is SvgPicture) {
      return icon.addPadding(padding);
    }
    if (icon is String) {
      return ImageController(icon, svgColor: color).addPadding(padding);
    }
    return icon;
  }

  @override
  State<UiButton> createState() => _UiButtonState();
}

class _UiButtonState extends State<UiButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? themeStyle = Theme.of(context).elevatedButtonTheme.style;
    final ButtonStyle baseStyle =
        (widget.style?.merge(themeStyle) ?? themeStyle) ?? const ButtonStyle();

    final Color effectiveLabelColor =
        widget.isDisabled
            ? (widget.disabledLabelColor ?? UiColors.textMuted)
            : (widget.labelColor ?? UiColors.textWhite);

    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTapDown: (_) {
          if (!widget.isDisabled && !widget.isLoading) {
            setState(() => _isPressed = true);
          }
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
        },
        child: ZoAnimatedGradientBorder(
          gradientColor:
              widget.showAnimatedBorder == true
                  ? widget.gradientColors
                  : [Colors.transparent],
          borderRadius: widget.borderRadius,
          animationDuration: widget.gradientAnimationDuration,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: ElevatedButton(
              onPressed:
                  (!widget.isDisabled && !widget.isLoading)
                      ? widget.onPressed
                      : widget.disabledOnPressed,
              style: ElevatedButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                overlayColor: UiColors.strokeStrong,
              ).merge(
                baseStyle.copyWith(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (widget.isDisabled) {
                      return widget.disabledBackgroundColor ??
                          baseStyle.backgroundColor?.resolve(states);
                    }
                    return widget.backgroundColor ??
                        baseStyle.backgroundColor?.resolve(states);
                  }),
                  shadowColor: WidgetStateProperty.all<Color?>(
                    widget.shadowColor,
                  ),
                  alignment: widget.labelAlign,
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    widget.borderColor != null
                        ? RoundedRectangleBorder(
                          side: BorderSide(color: widget.borderColor!),
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        )
                        : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        ),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: widget.prefixIcon != null && !widget.isLoading,
                    child: widget.buildIcon(
                      widget.prefixIcon,
                      const EdgeInsets.only(right: 8),
                      effectiveLabelColor,
                    ),
                  ),
                  Visibility(
                    visible: !widget.isLoading,
                    replacement: const SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    child: Text(
                      widget.label,
                      style: UiTextStyle.body16(
                        color: effectiveLabelColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.suffixIcon != null && !widget.isLoading,
                    child: widget.buildIcon(
                      widget.suffixIcon,
                      const EdgeInsets.only(left: 8),
                      effectiveLabelColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
