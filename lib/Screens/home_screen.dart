import 'package:flutter/material.dart';
import 'package:smca_application/login_page.dart';
import 'package:smca_application/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(context),
      ),
    );
  }

  Widget _page(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            const SizedBox(height: 80.0),
            _signInButton(context),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(360),
      ),
      margin: const EdgeInsets.all(20),
      elevation: 10.0,
      child: const Column(
        children: [
          CircleAvatar(
            radius: 100, // Ajusta el radio según tus necesidades
            backgroundImage: AssetImage('assets/img/logo.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        elevation: 8, // Sombra del botón
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Iniciar sesión",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0),
        ),
      ),
    );
  }
}
