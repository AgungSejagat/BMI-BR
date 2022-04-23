import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final String text;
  final IconData gender;
  final Color color;
  const GenderCard(this.text, this.gender, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            gender,
            size: 50,
            color: color,
          ),
          SizedBox(height: 25),
          Text(
            text,
            style: TextStyle(fontSize: 25, color: color),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 8),
      ),
    );
  }
}
