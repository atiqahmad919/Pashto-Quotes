import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      color: Colors.deepPurple,
      backgroundColor: Colors.white,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.favorite, size: 30, color: Colors.white),
        Icon(Icons.person, size: 30, color: Colors.white),
      ],
      onTap: onTap,
    );
  }
}
