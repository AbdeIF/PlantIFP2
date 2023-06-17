import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
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
        MaterialPageRoute(builder: (context) => ContentScreen()),
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




// ============================================================================================

//                                        SEGUNDA TELA

// ============================================================================================

class ContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double contentHeight = screenHeight - 78;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: screenWidth,
              height: 269,
              decoration: BoxDecoration(
                color: Color(0xFF459473),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 42,
            left: 33,
            child: Text(
              'PlantIFP2',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 115,
            left: 45,
            width: 261,
            height: 72,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Explore ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextSpan(
                    text: 'e ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextSpan(
                    text: 'conheça\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextSpan(
                    text: 'espécies de plantas\nno IFPI Campus Pedro II.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Positioned(
            top: 200,
            left: 45,
            width: 199,
            height: 42,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              elevation: 4,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
              child: InkWell(
                onTap: () {
                  // Lógica para lidar com o clique no botão
                },
                child: Center(
                  child: Text(
                    'Como começar?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF459473),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 286,
            left: 20,
            right: 20,
            bottom: 58,
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.4,
                        height: contentHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF459473),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'images/plant.jpg',
                                width: screenWidth * 0.4,
                                height: contentHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  'Planta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.4,
                        height: contentHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF459473),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'images/plant.jpg',
                                width: screenWidth * 0.4,
                                height: contentHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  'Planta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.4,
                        height: contentHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF459473),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'images/plant.jpg',
                                width: screenWidth * 0.4,
                                height: contentHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  'Planta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.4,
                        height: contentHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF459473),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'images/plant.jpg',
                                width: screenWidth * 0.4,
                                height: contentHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  'Planta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.4,
                        height: contentHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF459473),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'images/plant.jpg',
                                width: screenWidth * 0.4,
                                height: contentHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  'Planta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.4,
                        height: contentHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF459473),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'images/plant.jpg',
                                width: screenWidth * 0.4,
                                height: contentHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Text(
                                  'Planta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'um'),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: 'um'),
      ]),
    );
  }
}
