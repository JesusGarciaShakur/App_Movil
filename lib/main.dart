import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smca_application/Screens/home_screen.dart';
import 'package:smca_application/Screens/profile.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Si aún estamos esperando la comprobación de autenticación, mostramos una pantalla de carga.
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            // Si hay una sesión iniciada, redirigimos a notificaciones por el momento
            return const Profile();
          } else {
            // Si no hay una sesión iniciada, redirigimos a la página de inicio de sesión.
            return const HomePage();
          }
        }
      },
    );
  }
}
