import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:webazin/data/extensions/text_extension.dart';
import 'package:webazin/utils/utils.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final bool isLoading;
  final bool isEnable;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.isLoading = false,
    this.isEnable = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? 12.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * math.pi;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.zero, //
          child: ElevatedButton(
            onPressed: () {
              if (!widget.isLoading && widget.isEnable) {
                widget.onPressed?.call();
              }
            }, //
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor ?? Colors.greenAccent.withValues(alpha: widget.isEnable ? 1 : 0.5), //
              shadowColor: widget.backgroundColor ?? context.theme.cardColor, //
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // حذف فضای اضافه
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            ),
            child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.credit_card_rounded,color: Colors.green,),
                    ),
                    Text(
                      // 'text',
                      widget.text,
                    ).titleLarge(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withValues(alpha: widget.isEnable ? 1 : 0.5),
                    ),
                  ],
                ), //
          ),
        );
      },
    );
  }
}

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final bool isLoading;
  final List<Color>? gradientColors;
  final Color? textColor;

  const GradientButton({super.key, required this.text, required this.onPressed, this.gradientColors, this.textColor, this.borderRadius, this.isLoading = false});

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? 12.0;
    final colors =
        widget.gradientColors ??
        [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withValues(alpha: 0.6), Theme.of(context).primaryColor.withValues(alpha: 0.3)]; // پیش‌فرض

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * math.pi;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(angle), // تغییر زاویه گرادینت
              colors: colors,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              if (!widget.isLoading) {
                widget.onPressed?.call();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // چون گرادینت داریم
              shadowColor: Colors.transparent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            ),
            child: Text(
              widget.text,
              style: TextStyle(color: widget.textColor ?? Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class AppButtonBorder extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final MainAxisSize? mainAxisSize;

  const AppButtonBorder({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.textColor,
    this.textFontWeight,
    this.fontSize,
    this.borderRadius,
    this.padding,
    this.leadingIcon,
    this.trailingIcon,
    this.mainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.black,
        elevation: 0,
        backgroundColor: backgroundColor ?? Colors.white,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        side: BorderSide(color: borderColor ?? AppColors.primaryColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        children: [
          if (leadingIcon != null) ...[leadingIcon!, const SizedBox(width: 8.0)],
          Text(
            text,
            style: textStyle ?? TextStyle(color: textColor ?? AppColors.primaryColor, fontSize: fontSize ?? 14, fontWeight: textFontWeight ?? FontWeight.w500),
          ),
          if (trailingIcon != null) ...[const SizedBox(width: 8.0), trailingIcon!],
        ],
      ),
    );
  }
}
