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

int selectedIndex = 2; // Índice inicial para el bottom navigation bar

double altura = 0.0;
double tamanio = 0.0;
int ids = 0;

class _ProfileState extends State<Profile> {
  late String? userEmail; // Variable para almacenar el correo electrónico
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
          title: const Text("Perfil de usuario"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.account_circle, size: 140, color: Colors.blue),
                const SizedBox(height: 20),
                const Text(
                  "Información del perfil",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Correo electrónico: $userEmail',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Color.fromARGB(50, 0, 0, 0),
                        thickness: 1,
                        height: 20,
                      ),
                      Text('ID de contenedor: $ids',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Color.fromARGB(50, 0, 0, 0),
                        thickness: 1,
                        height: 20,
                      ),
                      Text('Capacidad del contenedor: $tamanio litros',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Color.fromARGB(50, 0, 0, 0),
                        thickness: 1,
                        height: 20,
                      ),
                      Text('Altura del contenedor: $altura cm',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Color.fromARGB(50, 0, 0, 0),
                        thickness: 1,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      minWidth:MediaQuery.of(context).size.width * 0.8 ,
                      height: 50,
                      highlightColor: Color.fromARGB(255, 65, 17, 255)  ,
                      splashColor:Color.fromARGB(255, 65, 17, 255) ,
                      color:Colors.indigoAccent ,
                      shape: const StadiumBorder(),
                      child: const Text("Cerrar sesión",style: TextStyle(
                          color: AppTheme.iconColor,
                          fontSize: 18
                          ),
                        
                        ),
                  ),

                const SizedBox(height: 20),
                
                MaterialButton(
                  onPressed:() {
                      final ruta1 = MaterialPageRoute(builder: (context) {
                        return const SignIn();
                      });
                      Navigator.push(context, ruta1);
                    },
                      minWidth:MediaQuery.of(context).size.width * 0.8 ,
                      height: 50,
                      highlightColor: Color.fromARGB(255, 215, 234, 249)  ,
                      splashColor:Color.fromARGB(255, 215, 234, 249) ,
                      color:Color.fromARGB(255, 249, 249, 249) ,
                      shape: const StadiumBorder(),
                      child: Text("Cambiar de contenedor",style: TextStyle(
                          color: Color.fromARGB(255, 114, 37, 182),
                          fontSize: 18
                          ),
                        
                        ),
                  ),


           
                const SizedBox(height: 20),
                
              ],
            ),
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
              label: 'Información',
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
      setState(() {
        altura = convertir(altu);
      });
    } else {
      print('no encontro altura.');
    }
    final snapshot2 = await ref.child('cantidad').get();
    if (snapshot2.exists) {
      final tama = snapshot2.value.toString();
      setState(() {
        tamanio = convertir(tama);
      });
    } else {
      print('no encontro tamaño.');
    }

    final snapshot3 = await ref.child('id').get();
    if (snapshot3.exists) {
      final id = snapshot3.value.toString();
      setState(() {
        ids = convertirInt(id);
      });
    } else {
      print('No encontro id.');
    }
  }
}
