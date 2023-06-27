import 'package:flutter/material.dart';

class TelaPlanta extends StatelessWidget {
  final String img;
  final String nomePopular;
  final String nomeCientifico;
  final String descricao;
  final String periculosidade;

  const TelaPlanta({
    Key? key,
    required this.img,
    required this.nomePopular,
    required this.nomeCientifico,
    required this.descricao,
    required this.periculosidade,
  }) : super(key: key);

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
            top: 129,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        margin: EdgeInsets.all(3),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView(
                      padding: EdgeInsets.only(left: 35, right: 35, bottom: 0),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                nomePopular,
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
                                nomeCientifico,
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
                                descricao,
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
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                periculosidade,
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
        ],
      ),
    );
  }
}
