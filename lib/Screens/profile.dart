import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/container.dart';
import 'package:smca_application/Screens/home_screen.dart';
import 'package:smca_application/Screens/notifications.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
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

class _ProfileState extends State<Profile> {
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
              Icons.notification_add,
              color: AppTheme.textColor,
            ),
            label: 'Notificaciones',
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
        ruta = MaterialPageRoute(builder: (context) => const Notifications());
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
