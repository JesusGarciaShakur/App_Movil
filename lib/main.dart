
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smca_application/Screens/container.dart';
import 'package:smca_application/Screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

  double altura = 0;
  double tamanio = 0;
  int ids = 0;


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

 

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
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

void validateContent() async {
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

      final snapshot3 = await ref.child('id').get();
      if (snapshot3.exists) {
        final id = snapshot3.value.toString();
        ids = convertirInt(id);
      } else {
        print('No encontro id.');
      }
      
      final route1 = MaterialPageRoute(
          builder: (context) => ContainerDetails(
                imagePath: "",
                title1: '',
                title2: altura,
                height: tamanio,
                id: ids,
              ));
              Navigator.push(context,route1);
}
    return 
    StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          // Si aún estamos esperando la comprobación de autenticación, mostramos una pantalla de carga.
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
        validateContent();
            // Si hay una sesión iniciada, redirigimos a notificaciones por el momento
            return ContainerDetails(imagePath: '',
             title1: 'title1',
              title2: altura,
               height: tamanio,
                id: ids);
  
          } else {
            // Si no hay una sesión iniciada, redirigimos a la página de inicio de sesión.
            return const HomePage();
          }
        }
      },
    );
  }







}
