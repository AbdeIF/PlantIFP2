import 'package:PlantIFP2/scanner.dart';
import 'package:flutter/material.dart';

class TelaTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double contentHeight = screenHeight;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            // Menu Superior
            top: 0,
            left: 0,

            child: Container(
              width: screenWidth,
              height: 0.14 * screenHeight,
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
              child: Center(
                child: Text(
                  'PlantIFP2',
                  style: TextStyle(
                    fontSize: 0.055 * screenHeight,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.16 * screenHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 0.04 * screenWidth),
              children: [
                SizedBox(height: 0.015 * screenHeight),
                Text(
                  'Como Começar?',
                  style: TextStyle(
                    fontSize: 0.04 * screenHeight,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF459473),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 0.03 * screenHeight),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image.asset(
                    'images/help.png',
                    width: 0.8 * screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 0.016 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.05 * screenWidth,
                      child: Text(
                        '1.',
                        style: TextStyle(
                          fontSize: 0.04 * screenHeight,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF459473),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 0.02 * screenWidth),
                    Expanded(
                      child: Text(
                        'Procure um dos QR Codes espalhados pelo campus ou acesse o catálogo na tela inicial do app.',
                        style: TextStyle(
                          fontSize: 0.025 * screenHeight,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.03 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.05 * screenWidth,
                      child: Text(
                        '2.',
                        style: TextStyle(
                          fontSize: 0.04 * screenHeight,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF459473),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 0.02 * screenWidth),
                    Expanded(
                      child: Text(
                        'Abra o leitor de QR Code na tela inicial do app e aponte a câmera para o código.',
                        style: TextStyle(
                          fontSize: 0.025 * screenHeight,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.03 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.05 * screenWidth,
                      child: Text(
                        '3.',
                        style: TextStyle(
                          fontSize: 0.04 * screenHeight,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF459473),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 0.02 * screenWidth),
                    Expanded(
                      child: Text(
                        'Aguarde a identificação do código e aproveite as informações sobre a planta.',
                        style: TextStyle(
                          fontSize: 0.025 * screenHeight,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.03 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.05 * screenWidth,
                      child: Text(
                        '4.',
                        style: TextStyle(
                          fontSize: 0.04 * screenHeight,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF459473),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 0.02 * screenWidth),
                    Expanded(
                      child: Text(
                        'Aproveite a experiência e descubra mais sobre a natureza ao seu redor!',
                        style: TextStyle(
                          fontSize: 0.025 * screenHeight,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.03 * screenHeight),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF459473),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(4, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 179, 5, 5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRCodePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TelaTutorial(),
  ));
}
