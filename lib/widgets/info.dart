import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String img;
  final String nomePopular;
  final String nomeCientifico;
  final String descricao;
  final String periculosidade;

  const InfoWidget({
    Key? key,
    required this.img,
    required this.nomePopular,
    required this.nomeCientifico,
    required this.descricao,
    required this.periculosidade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Container(
              margin: const EdgeInsets.only(left: 35, top: 35, right: 35),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Image.asset(
                img,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 35),
            alignment: Alignment.centerLeft,
            child: Text(
              nomePopular,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF459473),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 35),
            alignment: Alignment.centerLeft,
            child: Text(
              nomeCientifico,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 35),
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
            margin: const EdgeInsets.only(top: 10, left: 35),
            alignment: Alignment.centerLeft,
            child: Text(
              descricao,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 35),
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
            margin: const EdgeInsets.only(top: 10, left: 35),
            alignment: Alignment.centerLeft,
            child: Text(
              periculosidade,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
