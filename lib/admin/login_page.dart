import 'package:PlantIFP2/admin/telaCatalogoAdmin.dart';
import 'package:flutter/material.dart';
import '../database/db.dart';
import '../TelaCatalogo.dart';

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
        backgroundColor: Color(0xFF459473),
        automaticallyImplyLeading: false,
        toolbarHeight: 119,
        
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
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
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
                    MaterialPageRoute(builder: (context) => telaCalogoAdmin()),
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
                          child: Text('Fechar', style: TextStyle(color: Colors.green),),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF459473),
                padding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
