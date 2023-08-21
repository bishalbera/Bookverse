import 'package:flutter/cupertino.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;
  final TextAlign textAlign;

  const GradientText(
      {super.key,
      required this.text,
      required this.gradient,
      required this.style,
      required this.textAlign});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}
