import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:PlantIFP2/widgets/info.dart';

import 'database/db.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';
  List<String> tickets = [];
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  bool _isTicketValidated = false;

  @override
  void initState() {
    super.initState();
    readQRCode();
    _refreshData();
  }

  void readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );

    bool isValidated = await validateTicket(code);

    setState(() => ticket = code != '-1' ? code : 'Não validado');
    _isTicketValidated = isValidated; // Adicione esta linha
  }

  Future<bool> validateTicket(String ticket) async {
    final plants = await DBPlant.getAllData();
    List<String> plantNames =
        plants.map((plant) => plant['nome_p'] as String).toList();
    return plantNames.contains(ticket);
  }

  void _refreshData() async {
    final plants = await DBPlant.getAllData();
    setState(() {
      _allData = plants;
      _isLoading = false;
    });
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
              margin: EdgeInsets.only(top: 42, left: 33),
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
                } else if (_isTicketValidated) ...{
                  InfoWidget(
                    img: 'images/plants/$ticket.jpg',
                    nomePopular: ticket,
                    nomeCientifico: _allData.firstWhere(
                        (plant) => plant['nome_p'] == ticket)['nome_c'],
                    descricao: _allData.firstWhere(
                        (plant) => plant['nome_p'] == ticket)['descricao'],
                    periculosidade: _allData.firstWhere(
                        (plant) => plant['nome_p'] == ticket)['periculosidade'],
                  ),
                } else ...{
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
