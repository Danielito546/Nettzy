import 'package:flutter/material.dart';
import 'package:nettzy/database/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nettzy/screens/login_screens.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  void _register(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      await DatabaseHelper.instance.insertUser(username, password);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registro exitoso'),
          content: Text('El usuario se registró correctamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Se produjo un error al registrar el usuario.'),
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
        title: Text('Registro'),
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
                color: Colors.white,
                width: 0.0,
              ),
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
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Crear Usuario',
                        prefixIcon: Icon(Icons.person_2),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 156, 216, 242)),
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        filled: false,
                        fillColor: Color.fromARGB(255, 156, 216, 242),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Crear Contraseña',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromARGB(255, 38, 146, 235),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible =
                                  !_passwordVisible; // Alternar la visibilidad de la contraseña
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        filled: false,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                      ),
                      obscureText: !_passwordVisible,
                    ),
                    SizedBox(height: 28.0),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          onPressed: () => _register(context),
                          child: Text('Registrarse'),
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
                      onPressed: () => Navigator.pop(context),
                      child: Text('Volver'),
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
}
