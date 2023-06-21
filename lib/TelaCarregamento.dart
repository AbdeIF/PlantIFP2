import 'dart:async';
import 'package:flutter/material.dart';

import 'TelaCatalogo.dart';

class TelaCarregamento extends StatefulWidget {
  @override
  _TelaCarregamento createState() => _TelaCarregamento();
}

class _TelaCarregamento extends State<TelaCarregamento> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Color(0xFF459473),
    ).animate(_animationController);
    _animationController.forward();
    Timer(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaCatalogo()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Cor de fundo preta
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3, // Opacidade da imagem
                child: Image.asset(
                  'images/background.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PlantIFP2',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 361,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _colorAnimation.value,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Ⓒ ADS 2021',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}