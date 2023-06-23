import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';
  List<String> tickets = [];

  @override
  void initState() {
    super.initState();
    readQRCode();
  }

  void readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
  }

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
                color: const Color(0xFF459473),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: const [
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
              style: const TextStyle(
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
            bottom: 0,
            child: Column(
              children: [
                if (ticket == '' || ticket == 'Não validado' || ticket == '-1') ...{
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Nenhum Qr Code lido...',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF459473),
                      ),
                    ),
                  ),
                } else ...{
                  Container(
                    height: contentHeight -
                        500, // Defina a altura para ocupar metade da tela
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 35, top: 35, right: 35),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Image.asset(
                        'images/plant.jpg',
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      height: contentHeight,
                      child: ListView(
                        padding:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 0),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nome popular: $ticket',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF459473),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nome Científico',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Descrição:',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF459473),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Lorem ipsum nulla per suscipit orci nullam pretium proin sagittis, gravida hac platea rhoncus porttitor varius faucibus curae urna, nisi orci aliquam hendrerit sed pellentesque at nec. per fames cubilia aliquet sollicitudin integer.',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Periculosidade:',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF459473),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Baixa.',
                                  style: const TextStyle(
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
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}



/**
 * if (ticket != '')
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Ticket: $ticket',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
 */