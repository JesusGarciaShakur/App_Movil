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
  bool _expanded = false;
  bool _expanded1 = false;
  bool _expanded2 = false;
  bool _expanded3 = false;
  bool _expanded4 = false;
  bool _expanded5 = false;
  bool _expanded6 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Información"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            children: [
              const Text(
                "Recomendaciones para el SMCA",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Color.fromARGB(50, 0, 0, 0),
                thickness: 1,
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded =
                        !_expanded; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText(
                  "Porcentajes",
                  _expanded,
                  "Se recomienda mantener el procentaje del dispostivo entre el 20% y el 85% para evitar desbordamientos y que el dispoditivo sufra daños.",
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded1 =
                        !_expanded1; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText(
                  "Orientación del dispositivo",
                  _expanded1,
                  "El panel solar deberá estar orientado hacia el sur, para aprovechar de mejor manera la carga solar.",
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
                  "Si desea cambiar el dispositivo seleccionado diríjase al perfil y presione la opción cambiar dispositivo, después de eso bastará con seleccionar el dispositivo que se necesite.",
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
                  'Si deseas cambiar de contraseña, solo deberás ingresar a la sección de perfil y presionar sobre la opción de cambiar contraseña, posterioirmente se enviará un correo electrónico a tu cuenta, finalmente deberás completar el formulario.',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded4 =
                        !_expanded4; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText("Componentes internos", _expanded4,
                    'No intentes abrir ni manipular los componentes internos del dispositivo, ya que esto podría causar daños irreparables.'),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded5 =
                        !_expanded5; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText("Reportar problemas", _expanded5,
                    'Si notas algún problema con el funcionamiento del dispositivo, como lecturas inexactas del nivel de agua o fallos en la bomba, reporta el problema al fabricante o al proveedor de servicios lo antes posible por medio de la pagina web para que puedan brindarte asistencia técnica'),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expanded6 =
                        !_expanded6; // Cambia el estado de expansión al presionar el texto
                  });
                },
                child: _buildExpandableText(
                    "Consulta con el fabricante",
                    _expanded6,
                    'Si tienes dudas sobre el mantenimiento o el uso adecuado del dispositivo, no dudes en ponerte en contacto con el fabricante para obtener orientación y asistencia adicional.'),
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
            border: Border.all(color: const Color.fromARGB(72, 0, 0, 0)),
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
              border: Border.all(color: const Color.fromARGB(72, 0, 0, 0)),
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
