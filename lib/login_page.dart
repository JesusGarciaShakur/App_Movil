import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/create_account_screen.dart';
import 'package:smca_application/global/common/toast.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';
import 'package:smca_application/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


final FirebaseAuthService _auth = FirebaseAuthService();



  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
            _inputField("Correo", _emailController),
            const SizedBox(height: 30.0),
            _inputField("Contraseña", _passwordController, isPassword: true),
            const SizedBox(height: 50.0),

            ElevatedButton(onPressed: _signIn,
              style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16.0)),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Iniciar sesión",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          )), 
          ),




            const SizedBox(height: 30.0),
            _passText(),
            ElevatedButton(onPressed:(){
              final ruta2= MaterialPageRoute(
                  builder: (context)=> const CreateAccount());
                  Navigator.push(context, ruta2);
            }
             , child: Text("crear una cuenta"))
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.iconColor, width: 2),
          shape: BoxShape.circle),
      child: const Icon(
        Icons.person,
        color: AppTheme.iconColor,
        size: 120.0,
      ),
    );
  }

// Widgets de Usuario y contraseña
  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(color: AppTheme.textColor),
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppTheme.textColor),
          enabledBorder: border,
          focusedBorder: border),
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


  void _signIn() async{

  String email =_emailController.text;
  String password = _passwordController.text;


 if ( email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor completa todos los campos.')),
        );
        return;
      }
  User? user= await _auth.signInWithEmailAndPassword(email, password);


  if (user != null ){
    showToast(message: "el usaurio a ingresado");
     final ruta1= MaterialPageRoute(
                  builder: (context)=> const SignIn());
                  Navigator.push(context, ruta1);


  }
 }
}
