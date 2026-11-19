import 'package:flutter/material.dart';


class WaveBackground extends StatelessWidget {
  const WaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipPath(
          clipper: const WaveClipper(isBack: true),
          child: Container(color: const Color(0xFF6CC3C7)),
        ),
        ClipPath(
          clipper: const WaveClipper(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF008A92), Color(0xFF0DABB2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class WaveClipper extends CustomClipper<Path> {
  final bool isBack;
  const WaveClipper({this.isBack = false});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final base = size.height - 34;
    double x(double v) => w * v / 200;

    final path = Path()..lineTo(w, 0);

    if (isBack) {
      path.lineTo(w, base + 22);
      path.cubicTo(x(160), base + 36, x(130), base + 10, x(96), base + 20);
      path.cubicTo(x(60), base + 30, x(30), base + 34, 0, base + 24);
    } else {
      path.lineTo(w, base + 10);
      path.cubicTo(x(165), base + 28, x(135), base + 26, x(104), base + 14);
      path.cubicTo(x(72), base + 2, x(36), base + 6, 0, base + 18);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant WaveClipper oldClipper) =>
      oldClipper.isBack != isBack;
}