import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleLoader extends StatefulWidget {
  const GoogleLoader({super.key});

  @override
  State<GoogleLoader> createState() => _GoogleLoaderState();
}

class _GoogleLoaderState extends State<GoogleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _colorAnimation = _controller.drive(
      TweenSequence<Color?>([
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue, end: Colors.red),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.yellow),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.yellow, end: Colors.green),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.green, end: Colors.blue),
          weight: 25,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return SizedBox(
          width: 30.w,
          height: 30.h,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color?>(_colorAnimation.value),
          ),
        );
      },
    );
  }
}
