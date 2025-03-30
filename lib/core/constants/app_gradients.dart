import 'package:flutter/material.dart';

class Gradients extends StatelessWidget {
  const Gradients({
    super.key,
    this.text,
    this.style,
    this.overflow,
    this.align,
    required this.gradient,
  });
  final String? text;
  final TextStyle? style;
  final Gradient gradient;
  final TextOverflow? overflow;
  final TextAlign? align;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        textAlign: align,
        text ?? "",
        style: style,
        softWrap: true,
        overflow: overflow,
      ),
    );
  }
}
