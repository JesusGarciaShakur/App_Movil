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

import 'package:flutter/material.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _LoginPageState();
}

class _LoginPageState extends State<CreateAccount> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPassController = TextEditingController();
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

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
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
            _inputField("Usuario", usernameController),
            const SizedBox(height: 30.0),
            _inputField("Email", emailController),
            const SizedBox(height: 30.0),
            _inputField("Contraseña", passwordController, isPassword: true),
            const SizedBox(height: 30.0),
            _inputField("Escriba nuevamente la contraseña", reEnterPassController, isPassword: true),
            const SizedBox(height: 30.0),
            _signInButton(),
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

// Botón de inicio de sesión
  Widget _signInButton() {
  return ElevatedButton(
    onPressed: () {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String reEnterPassword = reEnterPassController.text.trim();

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

      debugPrint("Usuario: $username");
      debugPrint("Email: $email");
      debugPrint("Contraseña: $password");

      final route2 = MaterialPageRoute(builder: (context) {
        return const SignIn();
      });
      Navigator.push(context, route2);
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
    );
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
