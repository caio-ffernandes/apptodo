import 'package:flutter/material.dart';

class ElementButton extends StatelessWidget {
  final String title;
  final Color color;
  final Widget screen;

  ElementButton({required this.title, required this.color, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Text(title),
      ),
    );
  }
}
