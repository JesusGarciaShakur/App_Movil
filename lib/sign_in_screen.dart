import 'package:flutter/material.dart';
import 'package:smca_application/Screens/home_screen.dart';
import 'package:smca_application/Screens/notifications.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:smca_application/Screens/watch_containers.dart';
import 'package:smca_application/theme/app_theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({ super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: AppTheme.bottomColor,
        body: ListView(
          children: [
            imageCard(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => openScreen(context, index),
          backgroundColor: AppTheme.color,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: AppTheme.bottomColor,
              icon: Icon(
                Icons.home,
                color: AppTheme.iconColor,
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppTheme.bottomColor,
              icon: Icon(
                Icons.favorite,
                color: AppTheme.iconColor,
              ),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppTheme.bottomColor,
              icon: Icon(
                Icons.notification_add,
                color: AppTheme.iconColor,
              ),
              label: 'Notificaciones',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppTheme.bottomColor,
              icon: Icon(
                Icons.person,
                color: AppTheme.iconColor,
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
        ruta = MaterialPageRoute(builder: (context) => const HomePage());
        break;
      case 1:
        ruta = MaterialPageRoute(builder: (context) => const WatchContainers());
        break;
      case 2:
        ruta = MaterialPageRoute(builder: (context) => const Notifications());
        break;
      case 3:
        ruta = MaterialPageRoute(builder: (context) => const Profile());
        break;
    }
    setState(() {
      selectedIndex = index;
      Navigator.push(context, ruta);
    });
  }
    Widget imageCard() {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Contenedores',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
              4,
              (index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: const Image(
                              image: AssetImage('assets/img/rotoplas.png'),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            onPressed: () {
                              final ruta4 = MaterialPageRoute(builder: (context){
                                return const WatchContainers();
                              });
                              Navigator.push(context, ruta4);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), // Espacio entre la imagen y el texto
                      const Text(
                        'Rotoplas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

 
}