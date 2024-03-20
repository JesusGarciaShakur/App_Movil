import 'package:flutter/material.dart';
import 'package:smca_application/create_account_screen.dart';
import 'package:smca_application/login_page.dart';
import 'package:smca_application/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => LoginPageState();

}

class LoginPageState extends State<HomePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
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
            _logo(),
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
  
  Card _logo() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(360),
    ),
    margin: const EdgeInsets.all(20),
    elevation: 10,
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
// Widgets de Usuario y contraseña
  Future<Widget> _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) async {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(color: AppTheme.iconColor),
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppTheme.iconColor),
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
          foregroundColor: Colors.black, backgroundColor: Colors.white, shape: const StadiumBorder(),
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
          foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: const StadiumBorder(),
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
