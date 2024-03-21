// import 'package:flutter/material.dart';

// class CreateAccount extends StatelessWidget {
//   const CreateAccount({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Crear nueva cuenta'),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/global/common/toast.dart';
import 'package:smca_application/login_page.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';
import 'package:smca_application/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _LoginPageState();
}

class _LoginPageState extends State<CreateAccount> {

// controlador de autentificacion
final FirebaseAuthService _auth = FirebaseAuthService();


  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _reEnterPassController = TextEditingController();

@override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _reEnterPassController.dispose();
    super.dispose();


   _scrollController.dispose();
    _focusNode.dispose();

  }





  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: AppTheme.bottomColor,
        body: _page(),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_scrollToBottomOnFocusChange);
  }

 

  void _scrollToBottomOnFocusChange() {
    if (_focusNode.hasFocus) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

   Widget _page() {
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50.0),
            _inputField("Usuario", _usernameController),
            const SizedBox(height: 30.0),
            _inputField("Email", _emailController),
            const SizedBox(height: 30.0),
            _inputField("Contraseña", _passwordController, isPassword: true),
            const SizedBox(height: 30.0),
            _inputField("Escriba nuevamente la contraseña", _reEnterPassController, isPassword: true),
            const SizedBox(height: 30.0),

            ElevatedButton(onPressed: (){
              _signUp();
            }, 
            style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
        child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Crear cuenta",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    ),

            ElevatedButton(onPressed: (){
                final ruta2= MaterialPageRoute(
                  builder: (context)=> const LoginPage());
                  Navigator.push(context, ruta2);
            }, 
          
      
        child:  const Text(
          "ya tengo una cuenta",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),

    
    ),
    ),

          
            const SizedBox(height: 30.0),


          ],
        ),
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



// funcion de inicio de sesión
void _signUp() async {

    String username = _emailController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String reEnterPassword = _reEnterPassController.text;

 if (username.isEmpty || email.isEmpty || password.isEmpty || reEnterPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor completa todos los campos.')),
        );
        return;
      }
      
      if (password != reEnterPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden.')),
        );
        return;
      }
    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null){
   showToast(message: "el Usuario se creo");

    final ruta1 = MaterialPageRoute(
    builder: (context)=> const SignIn() );
    Navigator.push(context, ruta1);
} 
}





  

  // Widget _passText() {
  //   return const Text(
  //     "¿Has olvidado la contraseña?",
  //     textAlign: TextAlign.center,
  //     style: TextStyle(
  //       fontSize: 16.0,
  //       color: Colors.black
  //       ),
  //     );
  // }
}
