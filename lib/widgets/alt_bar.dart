import 'package:flutter/material.dart';

class AltBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[900],
      height: 60,
      child: Center(
        child: Text(
          "Alt bar ??",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
