import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:PlantIFP2/widgets/info.dart';

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
      body: Column(
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            // Menu Superior
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
            child: Container(
              margin: EdgeInsets.only(top: 42 , left: 33),
              child: Text(
                'PlantIFP2',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                if (ticket == '' ||
                    ticket == 'Não validado' ||
                    ticket == '-1') ...{
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
                }else if (ticket == "Cannabis") ...{
                  InfoWidget(
                    img: 'images/plants/cannabis.jpg',
                    nomePopular: 'Maconha',
                    nomeCientifico: 'Cannabis sativa',
                    descricao: 'descricao',
                    periculosidade: 'Baixa.',
                  ),
                }else if (ticket == "Nim") ...{
                  InfoWidget(
                    img: 'images/plants/nim.jpg',
                    nomePopular: 'Nim',
                    nomeCientifico: 'Azadirachta indica A. Jus',
                    descricao: 'árvore da família Meliaceae, com distribuição natural no sul da Ásia e utilizada na produção de madeira e para fins medicinais.',
                    periculosidade: 'Baixa.',
                  ),
                }else ...{
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Planta não identificada...',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF459473),
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
