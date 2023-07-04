import 'dart:io';

import 'package:PlantIFP2/database/db.dart';
import 'package:flutter/material.dart';
import 'documentos_page.dart';
import '../TelaInfoPlantas.dart';
import '../scanner.dart';
import 'card-adm.dart';
import 'package:image_picker/image_picker.dart';

class TelaCatalogoAdmin extends StatefulWidget {
  @override
  State<TelaCatalogoAdmin> createState() => _TelaCatalogoAdminState();
}

class _TelaCatalogoAdminState extends State<TelaCatalogoAdmin> {
  List<Map<String, dynamic>> _allData = [];
  XFile? comprovante;
  XFile? comprovante2;

  bool _isLoading = true;

  void _refreshData() async {
    final plants = await DBPlant.getAllData();
    setState(() {
      _allData = plants;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _imgController = TextEditingController();
  final TextEditingController _nomepController = TextEditingController();
  final TextEditingController _nomecController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _periculosidadeController =
      TextEditingController();

  // Adicionar -------------
  Future<void> _addData() async {
    await DBPlant.createData(
        _imgController.text,
        _nomepController.text,
        _nomecController.text,
        _descricaoController.text,
        _periculosidadeController.text);
    _refreshData();
  }

  // Atualizar -------------
  Future<void> _updateData(int id) async {
    await DBPlant.updateData(
        id,
        _imgController.text,
        _nomepController.text,
        _nomecController.text,
        _descricaoController.text,
        _periculosidadeController.text);
    _refreshData();
  }

  // Deletar -------------
  void _deleteData(int id) async {
    await DBPlant.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green, content: Text("Planta Deletada!")));
  }

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _imgController.text = existingData['img'];
      _nomepController.text = existingData['nomeP'];
      _nomecController.text = existingData['nomeC'];
      _descricaoController.text = existingData['descricao'];
      _periculosidadeController.text = existingData['periculosidade'];
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IntrinsicHeight(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Tirar foto'),
                    onTap: tirarFoto,
                    trailing: comprovante2 != null
                        ? Image.file(File(comprovante2!.path))
                        : null,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Selecionar foto'),
                    onTap: selecionarFoto,
                    trailing: comprovante != null
                        ? Image.file(File(comprovante!.path))
                        : null,
                  ),
                  Divider(),
                  // TextField(
                  //   controller: _imgController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Image',
                  //   ),
                  // ),
                  TextField(
                    controller: _nomepController,
                    decoration: InputDecoration(
                      labelText: 'Nome Popular',
                    ),
                  ),
                  TextField(
                    controller: _nomecController,
                    decoration: InputDecoration(
                      labelText: 'Nome Científico',
                    ),
                  ),
                  TextField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                  TextField(
                    controller: _periculosidadeController,
                    decoration: InputDecoration(
                      labelText: 'Periculosidade',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addData();
                      }

                      if (id != null) {
                        await _updateData(id);
                      }

                      _imgController.text = "";
                      _nomepController.text = "";
                      _nomecController.text = "";
                      _descricaoController.text = "";
                      _periculosidadeController.text = "";

                      Navigator.pop(
                          context); // Fechar o BottomSheet após salvar os dados
                    },
                    child: Text(id == null ? 'Salvar' : 'Atualizar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  selecionarFoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => comprovante = file);
    } catch (e) {
      print(e);
    }
  }

  tirarFoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) setState(() => comprovante2 = file);
    } catch (e) {
      print(e);
    }
  }

  // -------------------------------------------------- CORPO DA PÁGINA ----------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double contentHeight = screenHeight - 78;
          return Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: 219,
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
                  'PlantIFP2(Admin)',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 95,
                left: 33,
                width: 261,
                height: 72,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Explore ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextSpan(
                        text: 'e ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextSpan(
                        text: 'conheça\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextSpan(
                        text: 'espécies de plantas\nno IFPI Campus Pedro II.',
                        style: TextStyle(
                          fontSize: 15,
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
                top: 160,
                left: 33,
                width: 210,
                height: 42,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  elevation: 4,
                  shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                  child: InkWell(
                    onTap: () => showBottomSheet(null),
                    child: Center(
                      child: Text(
                        'Adicionar Plantas',
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
                top: 226,
                left: 20,
                right: 20,
                bottom: 55,
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: contentHeight * 0.65,
                      ),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (screenWidth / 2) / (contentHeight * 0.43),
                              ),
                              itemCount: _allData.length,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 2),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TelaPlanta(
                                        img: _allData[index]['img'],
                                        nomePopular: _allData[index]['nome_p'],
                                        nomeCientifico: _allData[index]
                                            ['nome_c'],
                                        descricao: _allData[index]['descricao'],
                                        periculosidade: _allData[index]
                                            ['periculosidade'],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    height: contentHeight * 0.43,
                                    child: CardWidgetADM(
                                      img: _allData[index]['img'],
                                      nomePopular: _allData[index]['nome_p'],
                                      id: _allData[index]['id'],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
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
          );
        },
      ),
    );
  }
}
