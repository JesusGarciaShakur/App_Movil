import 'package:flutter/material.dart';
import 'package:smca_application/create_account_screen.dart';
import 'package:smca_application/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<HomePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.white,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50.0),
            _signInButton(),
            const SizedBox(height: 30.0),
            _createAccountButton(),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          shape: BoxShape.circle),
      child: const Icon(
        Icons.person,
        color: Colors.black,
        size: 120.0,
      ),
    );
  }

// Widgets de Usuario y contraseña
  Future<Widget> _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) async {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          enabledBorder: border,
          focusedBorder: border),
      obscureText: isPassword,
    );
  }

// Botón de inicio de sesión
  Widget _signInButton() {
    return ElevatedButton(
      onPressed: () {
        final ds1 = MaterialPageRoute(builder: (context) {
          return const LoginPage();
        });
        Navigator.push(context, ds1);
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16.0)),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Iniciar sesión",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          )),
    );
  }

  Widget _createAccountButton() {
    return ElevatedButton(
      onPressed: () {
        final route2 = MaterialPageRoute(builder: (context) {
          return const CreateAccount();
        });
        Navigator.push(context, route2);
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16.0)),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Crear cuenta",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          )),
    );
  }
}
