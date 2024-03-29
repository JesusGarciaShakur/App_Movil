import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smca_application/Screens/container.dart';
import 'package:smca_application/Screens/notifications.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:smca_application/theme/app_theme.dart';

class SignIn extends StatefulWidget {
  final ContainerDetails? selectedContainer;

  const SignIn({Key? key, this.selectedContainer}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {





int checkContianer=0;


  int selectedIndex = 0;
  ContainerDetails? _selectedContainer;

  @override
  void initState() {
    super.initState();
    _selectedContainer = widget.selectedContainer;
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedContainer != null) {
      return ContainerDetails(
        imagePath: _selectedContainer!.imagePath,
        title1: _selectedContainer!.title1,
        title2: _selectedContainer!.title2,
        height: _selectedContainer!.height,
        id: _selectedContainer!.id,
      );
    }

    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            
            imageCard(),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Lógica para el botón flotante (agregar)
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
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
          const SizedBox(height: 20.0),
          Table(
            children: [

              TableRow(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToContainerDetails(
                        context,
                        'assets/img/Tin750.png',
                        'Tinaco',
                        750,
                        102,
                        1
                      );
                    },
                    child: imageContainer(
                        'assets/img/Tin750.png', 'Tinaco', 750),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToContainerDetails(
                        context,
                        'assets/img/Tin1100.png',
                        'Tinaco',
                        1100,
                        140,
                        2
                      );
                    },
                    child: imageContainer(
                        'assets/img/Tin1100.png', 'Tinaco', 1100),
                  ),
                ],
              ),
              TableRow(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToContainerDetails(
                        context,
                        'assets/img/Tin1500.png',
                        'Tinaco',
                        1500,
                        150,
                        3
                      );
                    },
                    child: imageContainer(
                        'assets/img/Tin1500.png', 'Tinaco', 1500),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToContainerDetails(
                        context,
                        'assets/img/Tin2800.png',
                        'Tinaco',
                        2800,
                        118,
                        4
                      );
                    },
                    child: imageContainer(
                        'assets/img/Tin2800.png', 'Tinaco', 2800),
                  ),
                ],
              ),
              TableRow(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToContainerDetails(
                        context,
                        'assets/img/Tin5000.png',
                        'Tinaco',
                        5000,
                        177,
                        5
                      );
                    },
                    child: imageContainer(
                        'assets/img/Tin5000.png', 'Tinaco', 5000),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToContainerDetails(
                        
                        context,
                        'assets/img/Tin10000.png',
                        'Tinaco',
                        10000,
                        310,
                        6,
                      );
                    },
                    child: imageContainer(
                        'assets/img/Tin10000.png', 'Tinaco', 10000),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget imageContainer(String imagePath, String title1, double title2) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        color: AppTheme.iconColor,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  width: 120,
                  height: 120,
                  image: AssetImage(imagePath),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("${title2.toStringAsFixed(0)} litros" )
            ],
          ),
        ),
      ),
    );
  }

  void openScreen(BuildContext context, int index) {
    late MaterialPageRoute ruta;
    switch (index) {
      case 0:
        ruta = MaterialPageRoute(builder: (context) => const SignIn());
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
DatabaseReference typeContainer = FirebaseDatabase.instance.ref("usuarios/PJXMhNNDgFawm1WxVVidkPf4H5R2/datos/contenedor");

  
  void navigateToContainerDetails(BuildContext context, String imagePath,
      String title1, double title2, double height, int id) async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ContainerDetails(
          imagePath: imagePath,
          title1: title1,
          title2: title2,
          height: height,
          id:id
        ),
      ),
    );
   await typeContainer.set({
  'id':id,
  'altura':height,
  'cantidad':title2
  });


  }
}
