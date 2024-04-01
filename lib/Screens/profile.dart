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
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text("Cerrar sesión"),
          ),
          ElevatedButton(
            onPressed: () {
              final ruta1 = MaterialPageRoute(builder: (context) {
                return const SignIn();
              });
              Navigator.push(context, ruta1);
            },
            child: const Text('Cambiar de contenedor'),
          )
        ],
      ),
    );
  }
}
