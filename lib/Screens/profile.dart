import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/home_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body:  Column(
      children: [
        const Text("informacion del perfil"),

        ElevatedButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          final ruta1=MaterialPageRoute(
            builder: (context)=> const HomePage());
            Navigator.push(context, ruta1);

        }
        
   ,
        
        child: const Text("Cerrar sesion"))

      ],
      ),
    );
  }
}
