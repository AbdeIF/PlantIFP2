import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../database/db.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:flutter/material.dart';

// TextField(
//                 controller: _imgController,
//                 decoration: InputDecoration(
//                   labelText: 'Image',
//                 ),

class CardWidgetADM extends StatefulWidget {
  final String img;
  final String nomePopular;
  final int id;

  const CardWidgetADM({
    Key? key,
    required this.img,
    required this.nomePopular,
    required this.id,
  }) : super(key: key);

  @override
  State<CardWidgetADM> createState() => _CardWidgetADMState(id: id, img: img);
}

class _CardWidgetADMState extends State<CardWidgetADM> {
  int id;
  String img;
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  XFile? comprovante;
  String? imagePath;

  _CardWidgetADMState({required this.id, required this.img});

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

  final TextEditingController _nomepController = TextEditingController();
  final TextEditingController _nomecController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _periculosidadeController =
      TextEditingController();

  // Adicionar -------------

  Future<void> _addData() async {
    String? fileName;

    if (imagePath != null) {
      final file = File(imagePath!);
      final fileNameWithoutExtension = path.basenameWithoutExtension(file.path);
      final fileExtension = path.extension(file.path);

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final savedImagePath =
          path.join(appDir.path, '$fileNameWithoutExtension$fileExtension');

      await file.copy(savedImagePath);
      fileName = savedImagePath;
    }

    await DBPlant.createData(
      fileName ?? '',
      _nomepController.text,
      _nomecController.text,
      _descricaoController.text,
      _periculosidadeController.text,
    );

    _refreshData();
  }

// Atualizar -------------

  Future<void> _updateData(int id) async {
    String? fileName;

    if (imagePath != null) {
      final file = File(imagePath!);
      final fileNameWithoutExtension = path.basenameWithoutExtension(file.path);
      final fileExtension = path.extension(file.path);

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final savedImagePath =
          path.join(appDir.path, '$fileNameWithoutExtension$fileExtension');

      await file.copy(savedImagePath);
      fileName = savedImagePath;
    }

    await DBPlant.updateData(
      id,
      fileName ?? '',
      _nomepController.text,
      _nomecController.text,
      _descricaoController.text,
      _periculosidadeController.text,
    );

    _refreshData();
  }

// Deletar -------------

  void _deleteData(id) async {
    await DBPlant.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Planta Deletada!"),
      ),
    );
    _refreshData();
  }

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      // _imgController.text = existingData['img'];
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
                    trailing: comprovante != null
                        ? Image.file(File(comprovante!.path))
                        : null,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Selecionar foto'),
                    onTap: selecionarFoto,
                    trailing: comprovante != null
                        ? Image.file(File(comprovante!.path))
                        : null,
                  ),
                  Divider(),
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
                      } else {
                        await _updateData(id);
                      }

                      // _imgController.text = "";
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
      if (file != null) setState(() => img = file.path);
    } catch (e) {
      print(e);
    }
  }

  tirarFoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) setState(() => comprovante = file);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double contentHeight = screenHeight - 78;

    return Container(
      width: screenWidth * 0.4,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Text(
                  widget.nomePopular,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    showBottomSheet(widget.id);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _deleteData(widget.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
