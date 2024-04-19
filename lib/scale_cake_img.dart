import 'package:flutter/material.dart';

class ScaleCakeImg extends StatefulWidget {
  const ScaleCakeImg({super.key});

  @override
  State<ScaleCakeImg> createState() => _ScaleCakeImgState();
}

class _ScaleCakeImgState extends State<ScaleCakeImg>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> scale;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    scale = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Image.asset(
        "assets/pink-cake.png",
      ),
    );
  }
}
