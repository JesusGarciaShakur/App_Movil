import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/container.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:smca_application/theme/app_theme.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

int selectedIndex = 1;

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

class _InformationState extends State<Information> {
  bool _expanded1 = false;
  bool _expanded2 = false;
  bool _expanded3 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Informacion"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded1 =
                        !_expanded1; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText(
                  "Orientacion del dispositivo",
                  _expanded1,
                  "El panel solar debera estar orientado hacia el sur para aprovechar de mejor manera la carga solar.",
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded2 =
                        !_expanded2; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText(
                  "Cambio de dispositivo",
                  _expanded2,
                  "Si desea cambiar el dispositivo seleccionado dirijase a perfil y precione la opcion cambiar dispositivo despues de eso bastara con seleccionar el dispositivo que necesite.",
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded3 =
                        !_expanded3; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText(
                  "Cambio de contraseña",
                  _expanded3,
                  'Si deseas cambiar de contraseña solo deberas ingresar a la seccion de perfil precionar sobre la opcion de cambiar contraseña y se enviara un correo electronico a tu cuenta solo deberas completar el formulario.',
                ),
              ),
              // Aquí puedes agregar más textos expandibles si es necesario
            ],
          ),
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

  Widget _buildExpandableText(String title, bool expanded, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color.fromARGB(255, 255, 254, 254),
          ),
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
        if (expanded)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 18.0,
                color: Color.fromARGB(255, 3, 3, 3),
              ),
            ),
          ),
        const SizedBox(height: 20.0),
      ],
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
