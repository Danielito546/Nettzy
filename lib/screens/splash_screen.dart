import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:nettzy/screens/login_screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _controller; // Utilizamos 'late' para indicar que será inicializado más adelante
  late Animation<double>
      _animation; // Utilizamos 'late' para indicar que será inicializado más adelante
  final Color splashColor = Colors.blue;
  bool _showSpinner = true;

  @override
  void initState() {
    super.initState();
    // Inicializar el controlador y la animación
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Iniciar la animación del controlador

    // Esperar 5 segundos y luego mostrar el texto de bienvenida
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showSpinner = false; // Ocultar el spinner
      });
      _controller.reverse(); // Revertir la animación del controlador

      // Navegar a la pantalla de inicio de sesión después de un breve período de tiempo
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos del controlador de animación
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: splashColor, // Establecer el color de fondo
        child: Center(
          child: AnimatedOpacity(
            opacity:
                _showSpinner ? 1.0 : 0.0, // Controlar la opacidad del spinner
            duration: Duration(milliseconds: 500),
            child: FadeTransition(
              opacity: _animation, // Aplicar animación de fundido al texto
              child: _showSpinner
                  ? SpinKitFadingCircle(
                      color: Colors.white,
                      size: 90.0,
                    ) // Mostrar el spinner
                  : TextLiquidFill(
                      text: 'Welcome to Nettzy', // Texto de bienvenida
                      waveColor: Colors.white, // Color de la onda de texto
                      boxBackgroundColor:
                          splashColor, // Color de fondo de la caja
                      textStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                      boxHeight: 100.0,
                    ), // Mostrar el texto de bienvenida
            ),
          ),
        ),
      ),
    );
  }
}
