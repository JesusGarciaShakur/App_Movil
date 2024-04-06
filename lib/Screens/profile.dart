import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/Information.dart';
import 'package:smca_application/Screens/container.dart';
import 'package:smca_application/Screens/home_screen.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
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

class _ProfileState extends State<Profile> {
  late String? userEmail; // Variable para almacenar el correo electrónico
  late int selectedIndex = 2; // Índice inicial para el bottom navigation bar
  late DatabaseReference typeContainer;
  late DatabaseReference medida;
  late String userId = "";
  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener el correo electrónico y los datos de la base de datos al iniciar el estado del widget
    getUserEmail();
    _initializeDatabaseReferences();
    validateContent();
  }

  // Función para obtener el correo electrónico del usuario actual
  void getUserEmail() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        userEmail = currentUser.email;
      });
    }
  }

  void _initializeDatabaseReferences() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userId = currentUser.uid;
      typeContainer = FirebaseDatabase.instance
          .ref()
          .child("usuarios/$userId/datos/ultrasonico");
      medida = FirebaseDatabase.instance
          .ref()
          .child("usuarios/$userId/datos/contenedor/altura");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Column(
          children: [
            const Text("informacion del perfil"),
            // Muestra el correo electrónico del usuario
            Text('Correo electronico : $userEmail'),
            // Muestra los datos de la base de datos
            Text('Capacidad de litros: $tamanio'),
            Text('ID de contenedor: $ids'),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => openScreen(context, index),
          backgroundColor: const Color.fromARGB(237, 255, 255, 255),
          items: const [
            BottomNavigationBarItem(
              backgroundColor: AppTheme.textColor,
              icon: Icon(
                Icons.home,
                color: AppTheme.textColor,
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppTheme.textColor,
              icon: Icon(
                Icons.article_outlined,
                color: AppTheme.textColor,
              ),
              label: 'Informacion',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppTheme.textColor,
              icon: Icon(
                Icons.person,
                color: AppTheme.textColor,
              ),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  void openScreen(BuildContext context, int index) {
    late MaterialPageRoute ruta;
    switch (index) {
      case 0:
        ruta = MaterialPageRoute(
            builder: (context) => ContainerDetails(
                  imagePath: '',
                  title1: '',
                  title2: altura,
                  height: tamanio,
                  id: ids,
                ));
        break;
      case 1:
        ruta = MaterialPageRoute(builder: (context) => const Information());
        break;
      case 2:
        ruta = MaterialPageRoute(builder: (context) => const Profile());
        break;
    }
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(context, ruta);
  }

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
  }
}
