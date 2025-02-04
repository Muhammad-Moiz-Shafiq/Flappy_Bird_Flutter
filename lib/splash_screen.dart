import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatefulWidget {
  final Function()? onTap;
  const WelcomeScreen({super.key, required this.onTap});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Ensure proper visibility
      body: Center(
        child: GestureDetector(
          onTap: () {
            widget.onTap?.call(); // Safely invoke the callback
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/Animation/Animation.json',
                  controller: _controller,
                  height: 220,
                  width: 220,
                  fit: BoxFit.fill,
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                  },
                ),
                const SizedBox(height: 95),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    widget.onTap?.call(); // Safely invoke the callback
                  },
                  child: Text(
                    'Tap anywhere to continue...',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  )
                      .animate(onComplete: (contr) => contr.repeat())
                      .fade(duration: 3.seconds)
                      .then(delay: 500.ms)
                      .fadeOut(duration: 1.seconds),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
