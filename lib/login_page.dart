import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smca_application/Screens/container.dart';
import 'package:smca_application/global/common/toast.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';
import 'package:smca_application/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  static const String routename = 'Login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool? checkGuardarDatos = false;
  SharedPreferences? _prefs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double altura = 0;
  double tamanio = 0;
  int ids = 0;

  @override
  void initState() {
    cargarPreferencias();
    super.initState();
  }

  cargarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();

    // Obtener credenciales guardadas
    String? savedEmail = _prefs!.getString('email');
    String? savedPassword = _prefs!.getString('password');

    // Establecer el texto en los controladores de texto
    emailController.text = savedEmail ?? '';
    passwordController.text = savedPassword ?? '';
  }

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
            Container(
              margin: const EdgeInsets.symmetric(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  CheckboxListTile(
                    value: checkGuardarDatos,
                    title: const Text('Guardar mis credenciales'),
                    onChanged: (value) {
                      setState(() {
                        checkGuardarDatos = value;
                      });
                    },
                    secondary: const Icon(Icons.safety_check),
                  )
                ],
              ),
            ),
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
    await cargarPreferencias(); // Cargar preferencias antes de usarlas
    if (user != null) {
      showToast(message: "el usuario ha ingresado");

      // Verificar si el usuario ha seleccionado guardar sus credenciales
      if (checkGuardarDatos == true) {
        // Guardar las credenciales solo si el checkbox está marcado
        _prefs!.setString('email', email);
        _prefs!.setString('password', password);
        print('Credenciales guardadas exitosamente');
      } else {
        // Si el usuario no seleccionó guardar sus credenciales, borrar las credenciales guardadas
        _prefs!.remove('email');
        _prefs!.remove('password');
        print('Credenciales eliminadas');
      }

      final uid = FirebaseAuth.instance.currentUser!.uid;

      final ref =
          FirebaseDatabase.instance.ref("usuarios/$uid/datos/contenedor/");
      final snapshot = await ref.child('altura').get();
      if (snapshot.exists) {
        final altu = snapshot.value.toString();
        altura = convertir(altu);
      } else {
        print('no encontro altura.');
      }

      final snapshot2 = await ref.child('cantidad').get();
      if (snapshot2.exists) {
        final tama = snapshot2.value.toString();
        tamanio = convertir(tama);
      } else {
        print('no encontro tamaño.');
      }

      final snapshot3 = await ref.child('ids').get();
      if (snapshot3.exists) {
        final id = snapshot2.value.toString();
        ids = convertirInt(id);
      } else {
        print('No encontro id.');
      }

      validateContent();
    }
  }

  void validateContent() async {
    String snapGuar = '';
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('usuarios/$uid/datos/contenedor/id').get();
    snapGuar = snapshot.value.toString();
    print("$snapGuar valor de id en funcio");
    if (snapGuar != '0') {
      final route1 = MaterialPageRoute(
          builder: (context) => ContainerDetails(
                imagePath: "",
                title1: '',
                title2: altura,
                height: tamanio,
                id: ids,
              ));
      Navigator.push(context, route1);
    } else {
      final route = MaterialPageRoute(builder: (context) => const SignIn());
      Navigator.push(context, route);
    }
  }

  double convertir([String valor = '0']) {
    try {
      double convertidor = double.parse(valor);
      print("$convertidor en su proceso de com");
      return convertidor;
    } catch (e) {
      print("no se pudo comvertir error : $e");
      return 0.0;
    }
  }

  int convertirInt([String valor = '0']) {
    try {
      int convertidor = int.parse(valor);
      print("$convertidor en su proceso de com");
      return convertidor;
    } catch (e) {
      print("no se pudo comvertir error : $e");
      return 0;
    }
  }
}
