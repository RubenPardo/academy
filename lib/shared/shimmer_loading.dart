import 'package:flutter/material.dart';

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.height,
    this.borderRadius = 0,
  });

  final double height;
  final double borderRadius;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {

    return ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          return _shimmerGradient.createShader(bounds);
        },
        child: Container(
                width: double.infinity,
                height: widget.height,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
      ),
    );
  }
}