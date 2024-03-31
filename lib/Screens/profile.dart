import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/home_screen.dart';
import 'package:smca_application/sign_in_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          const Text("informacion del perfil"),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Cerrar sesión
              Navigator.of(context).popUntil(
                  (route) => route.isFirst); // Volver a la pantalla de inicio
            },
            child: const Text("Cerrar sesión"),
          ),
          ElevatedButton(
            onPressed: () {
              final route = MaterialPageRoute(builder: (context) {
                return const SignIn();
              });
              Navigator.push(
                  context, route); // Ir a la pantalla de inicio de sesión
            },
            child: const Text('Cambiar de contenedor'),
          ),
          ElevatedButton(
            onPressed: () {
              final ruta1 = MaterialPageRoute(builder: (context) {
                return const SignIn();
              });
              Navigator.push(context, ruta1);
            },
            child: Text('cambiar de contenedor'),
          )
        ],
      ),
    );
  }
}
