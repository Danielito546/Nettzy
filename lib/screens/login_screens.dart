import 'package:flutter/material.dart';
import 'package:nettzy/database/database_helper.dart';
import 'package:nettzy/screens/RegistrationScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nettzy/screens/home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  void _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        DatabaseHelper.table,
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );

      if (result.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Inicio de sesión fallido'),
            content: Text('Las credenciales ingresadas son inválidas.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Aceptar'),
              ),
            ],
          ),
        );
        Fluttertoast.showToast(
          msg: 'Credenciales incorrectas',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Se produjo un error al iniciar sesión.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Card(
            elevation: 12.0,
            margin: EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
              side: BorderSide(
                  color: const Color.fromARGB(255, 251, 251, 251), width: 0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 80.0,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 156, 216, 242)),
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        filled: false,
                        fillColor: Color.fromARGB(255, 156, 216, 242),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
                      ),
                    ),
                    SizedBox(height: 28.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromARGB(255, 38, 146, 235),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        filled: false,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
                      ),
                      obscureText: !_passwordVisible,
                    ),
                    SizedBox(height: 25.0),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          onPressed: () => _login(context),
                          child: Text('Iniciar sesión'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            minimumSize: Size(double.infinity, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            textStyle: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () => _goToRegistration(context),
                      child: Text('Crear cuenta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goToRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(),
      ),
    );
  }
}
