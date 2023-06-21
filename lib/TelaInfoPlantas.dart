import 'package:flutter/material.dart';
import 'package:plantifpi/scanner.dart';

class TelaCatalogo extends StatelessWidget {
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
            // Menu Superior
            top: 0,
            left: 0,
            child: Container(
              width: screenWidth,
              height: 119,
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
            // Conteúdo principal
            top: 119, // Ajuste a posição inicial do conteúdo principal
            left: 0,
            right: 0,
            bottom: 60,
            child: Column(
              children: [
                Container(
                  height: contentHeight -
                      400, // Defina a altura para ocupar metade da tela
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 35,
                        top: 35,
                        right: 35), // Margem de 45 pixels em todos os lados
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20), // Arredondamento de 20 pixels nas bordas
                    ),
                    child: Image.asset(
                      'images/plant.jpg',
                      width: screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16), // Espaçamento entre a imagem e o texto
                Expanded(
                  child: Container(
                    height: contentHeight - 400, // Defina uma altura para o ListView
                    child: ListView(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Planta',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF459473),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nome Científico',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Descrição:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF459473),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lorem ipsum nulla per suscipit orci nullam pretium proin sagittis, gravida hac platea rhoncus porttitor varius faucibus curae urna, nisi orci aliquam hendrerit sed pellentesque at nec. per fames cubilia aliquet sollicitudin integer.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Periculosidade:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF459473),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 35),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Baixa.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
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
                          offset: Offset(4, 0),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRCodePage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ],
                      ),
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
