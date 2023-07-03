import 'package:flutter/material.dart';

import '../database/db.dart';

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
  State<CardWidgetADM> createState() => _CardWidgetADMState(id: id);
}

class _CardWidgetADMState extends State<CardWidgetADM> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  int id;
  _CardWidgetADMState({required this.id});

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
  Future<void> _updateData(id) async {
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
  void _deleteData(id) async {
    await DBPlant.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green, content: Text("Planta Deletada!")));
    _refreshData();
  }

  void showBottomSheet(id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _imgController.text = existingData['img'];
      _nomepController.text = existingData['nome_p'];
      _nomecController.text = existingData['nome_c'];
      _descricaoController.text = existingData['descricao'];
      _periculosidadeController.text = existingData['periculosidade'];
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _imgController,
                decoration: InputDecoration(
                  labelText: 'Image',
                ),
              ),
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
        );
      },
    );
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
