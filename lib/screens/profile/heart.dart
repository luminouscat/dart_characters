import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.character});

  final Character character;

  @override
  State<Heart> createState() => _HeartState();
}

// we use the mixin for vscync, a ticker provider
class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    // vsync: this beacause it reference this widget itself (SingleTickerProviderStateMixin)
    _sizeAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(begin: 25.0, end: 40.0),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 40.0, end: 25.0),
        weight: 50,
      ),
    ]).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: widget.character.isFav ? Colors.red : Colors.grey,
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            // starting the animation
            _controller.reset(); // -> this resets the animation to the start
            _controller.forward(); // -> this grows the heart
            widget.character.toggleIsFav();
          },
        );
      },
    );
  }
}
