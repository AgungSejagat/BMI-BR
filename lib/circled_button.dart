import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final Color color;

  const CircleButton({
    Key? key,
    required this.icon,
    this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Icon(
        icon,
        size: 30,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        fixedSize: MaterialStateProperty.all(
          Size.fromRadius(30),
        ),
        foregroundColor: MaterialStateProperty.all(color),
      ),
    );
  }
}
