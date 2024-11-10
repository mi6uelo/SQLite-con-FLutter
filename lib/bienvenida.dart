import 'package:flutter/material.dart';
import 'dart:async';

class BienvenidaScreen extends StatefulWidget {
  const BienvenidaScreen({Key? key}) : super(key: key);

  @override
  _BienvenidaScreenState createState() => _BienvenidaScreenState();
}

class _BienvenidaScreenState extends State<BienvenidaScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Navega a la pantalla principal después de unos segundos
  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00001A), // Fondo color #00001a
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Agrega el logotipo en la parte superior
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset(
                'assets/images/logo.png', // Ruta del logo en assets
                width: 228,
                height: 184,
              ),
            ),
            const Text(
              'Bienvenido a Computer Solutions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto en color blanco
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white, // Indicador de progreso en color blanco
            ),
          ],
        ),
      ),
    );
  }
}
