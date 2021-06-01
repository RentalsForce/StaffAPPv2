import 'package:flutter/material.dart';

class PInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  factory PInkWell.dark({
    Widget child,
    VoidCallback onTap,
    BorderRadiusGeometry borderRadius,
    EdgeInsetsGeometry padding,
  }) =>
      PInkWell(
        child: child,
        onTap: onTap,
        borderRadius: borderRadius,
        padding: padding,
      );

  factory PInkWell.light({
    Widget child,
    VoidCallback onTap,
    BorderRadiusGeometry borderRadius,
    EdgeInsetsGeometry padding,
  }) =>
      PInkWell(
        child: child,
        onTap: onTap,
        borderRadius: borderRadius,
        padding: padding,
      );

  static Widget adaptive({
    Widget child,
    VoidCallback onTap,
    BorderRadiusGeometry borderRadius,
    EdgeInsetsGeometry padding,
  }) =>
      Builder(
        builder: (context) => PInkWell(
          child: child,
          onTap: onTap,
          borderRadius: borderRadius,
          padding: padding,
        ),
      );

  PInkWell({
    this.child,
    this.onTap,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.zero,
        splashColor: MediaQuery
            .of(context)
            .platformBrightness == Brightness.dark
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.1),
        highlightColor: Colors.black.withOpacity((MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark ? 0.2 : 0.05)),
        onTap: this.onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: child,
        ),
      ),
    );
  }
}
