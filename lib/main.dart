import 'package:flutter/material.dart';
import 'package:nettzy/screens/splash_screen.dart';
//import 'package:nettzy/screens/login_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
/* import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;

import 'package:nettzy/database/database_helper.dart'; */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fluttertoast.showToast(msg: 'Cargando...');

  // Obtener la ruta de la base de datos
  /*  String databasesPath = await getDatabasesPath();
  String dbPath =
      path_helper.join(databasesPath, DatabaseHelper.table); // Cambio aquí
  print('Ruta de la base de datos: $dbPath'); */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
