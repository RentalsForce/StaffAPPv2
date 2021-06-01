import 'package:flutter/widgets.dart';

class WCImageAsset extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final Color color;
  final BoxFit fit;

  WCImageAsset(
    this.asset, {
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/images/$asset',
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }
}
