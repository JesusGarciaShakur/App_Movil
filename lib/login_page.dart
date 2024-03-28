import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/notifications.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:smca_application/global/common/toast.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';
import 'package:smca_application/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int selectedIndex = 0;
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: AppTheme.bottomColor,
        body: ListView(
          children: [
            page(),
          ],
        ),
      ),
    );
  }

  Widget page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50.0),
            _inputField("Correo", emailController),
            const SizedBox(height: 30.0),
            _inputField("Contraseña", passwordController, isPassword: true),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                elevation: 8, // Agregar sombra al botón
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Iniciar sesión",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            _passText(),
          ],
        ),
      ),
    );
  }

  // En LoginPage
  void openScreen(BuildContext context, int index) {
    late MaterialPageRoute ruta;
    switch (index) {
      case 1:
        ruta = MaterialPageRoute(builder: (context) => const Notifications());
        break;
      case 2:
        ruta = MaterialPageRoute(builder: (context) => const Profile());
        break;
    }
    setState(() {
      selectedIndex = index;
    });
    if (index != 0) {
      Navigator.push(context, ruta);
    }
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.textColor, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: AppTheme.textColor,
        size: 120.0,
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.0),
      borderSide: const BorderSide(color: AppTheme.textColor),
    );
    return TextField(
      style: const TextStyle(color: AppTheme.textColor),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.textColor),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _passText() {
    return const Text(
      "¿Has olvidado la contraseña?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.0, color: AppTheme.textColor),
    );
  }

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos.')),
      );
      return;
    }
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: "el usuario ha ingresado");
      final route = MaterialPageRoute(builder: (context) => const SignIn());
      Navigator.push(context, route);
    }
  }

}
