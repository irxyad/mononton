import 'package:flutter/material.dart';
import '../constanta.dart';

class BtnTextIcon extends StatelessWidget {
  const BtnTextIcon(
      {super.key,
      this.bgColor,
      this.icon,
      this.textColor,
      this.padding,
      required this.text,
      required this.press});
  final Color? bgColor;
  final Widget? icon;
  final Widget text;
  final Color? textColor;
  final VoidCallback press;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: bgColor ?? white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            text,
            icon != null
                ? const SizedBox(
                    width: 8,
                  )
                : const SizedBox(
                    width: 0,
                  ),
            icon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BtnIconText extends StatelessWidget {
  const BtnIconText(
      {super.key,
      this.bgColor,
      this.icon,
      this.textColor,
      this.padding,
      this.width,
      this.radius,
      this.text,
      required this.press});
  final Color? bgColor;
  final Widget? icon;
  final Widget? text;
  final Color? textColor;
  final double? width;
  final double? radius;
  final VoidCallback press;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 18),
          color: bgColor ?? white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon ?? const SizedBox(),
            text != null
                ? const SizedBox(
                    width: 8,
                  )
                : const SizedBox(
                    width: 0,
                  ),
            text ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
