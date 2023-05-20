import 'package:flutter/material.dart';
import 'package:pokedex_challenge/core/extensions/color_utils.dart';

class NeumorphicContainer extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;

  NeumorphicContainer({
    super.key,
    required this.child,
    this.bevel = 10.0,
    required this.color,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2);

  @override
  _NeumorphicContainerState createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _isPressed ? widget.color : widget.color.mix(Colors.black, .1),
                _isPressed ? widget.color.mix(Colors.black, .05) : widget.color,
                _isPressed ? widget.color.mix(Colors.black, .05) : widget.color,
                widget.color.mix(Colors.black, _isPressed ? .2 : .5),
              ],
              stops: const [
                0.0,
                .4,
                .8,
                1.0,
              ]),
          boxShadow: _isPressed ? null : [
            BoxShadow(
              blurRadius: widget.bevel,
              offset: widget.blurOffset,
              color: Colors.black.withOpacity(0.4),
            )
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

