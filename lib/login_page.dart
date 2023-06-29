import 'package:flutter/material.dart';
import 'database/db.dart';
import 'TelaCatalogo.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String senha = senhaController.text;

                bool loginValido = await validarLogin(email, senha);

                if (loginValido) {
                  // Login válido, navegue para a próxima tela
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaCatalogo()),
                  );
                } else {
                  // Login inválido, exiba uma mensagem de erro
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Erro de login'),
                      content: Text('Credenciais inválidas. Tente novamente.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> validarLogin(String email, String senha) async {
    final db = DB.instance;
    return await db.validarLogin(email, senha);
  }
}
