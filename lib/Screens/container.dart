import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smca_application/global/common/toast.dart';
import 'package:smca_application/theme/app_theme.dart';

// Importa el widget Notifications
import 'notifications.dart';

class ContainerDetails extends StatefulWidget {
  final String imagePath;
  final String title1;
  final double title2;
  final double height;
  final int id;

  const ContainerDetails(
      {required this.imagePath,
      required this.title1,
      required this.title2,
      required this.height,
      required this.id});

  @override
  _ContainerDetailsState createState() => _ContainerDetailsState();
}

class _ContainerDetailsState extends State<ContainerDetails> {

  late DatabaseReference relay;
  late DatabaseReference relay2;
  late DatabaseReference typeContainer;
  late DatabaseReference medida;
  late String userId = "";

    double altura = 0.1;
  // variable para guardar consulta
  String altu = "0.1";
  double distaan = 0.1;
  double porcent = 0.1;
  // variable para controlar el controlador dela barra
  double linearValue = 0.1;
  double linearValue2 = 0.8;

  // Variable para guardar el estado de la bomba
  String getOnceValue = "0";
  String getTamanoConten = "0.0";

  // Index del menú de abajo
  int selectedIndex = 0;

  

  @override
  void initState() {
    super.initState();
    _initializeDatabaseReferences();
    _loadLinearValues();
  }

  void _loadLinearValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      linearValue = prefs.getDouble('linearValue') ?? 0.1;
      linearValue2 = prefs.getDouble('linearValue2') ?? 0.8;
    });
  }

  void _saveLinearValues() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('linearValue', linearValue);
    prefs.setDouble('linearValue2', linearValue2);
  }



void _initializeDatabaseReferences() {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    userId = currentUser.uid;
    relay = FirebaseDatabase.instance.ref().child("usuarios/$userId/datos/");
    relay2 = FirebaseDatabase.instance.ref().child("usuarios/$userId/datos/relay");
    typeContainer = FirebaseDatabase.instance.ref().child("usuarios/$userId/datos/ultrasonico");
    medida = FirebaseDatabase.instance.ref().child("usuarios/$userId/datos/contenedor/altura");
  }
}



  @override
  Widget build(BuildContext context) {
   
double convertir([String valor = '0.1']) {
      try {
        double convertidor = double.parse(valor);
            return convertidor;
      } catch (e) {
        print("no se pudo convertir error en pantalla de container: $e");
        return 0.0;
      }
    }

        typeContainer.onValue.listen((event)  {
          setState(()  {
              altu =   event.snapshot.value.toString().trim();
          });
        });

      relay2.onValue.listen((event)  {
       setState(()  {
        getOnceValue =  event.snapshot.value.toString();
      });
    });

      medida.onValue.listen((event) {
      setState(() {
        getTamanoConten =  event.snapshot.value.toString();
      });
    });

    distaan = convertir(altu);


    altura = convertir(getTamanoConten);
    // print("$altura altura traida de la pagina ");

    double calcularPor(double altura, double medida) {
      double alto = altura;
      double resultado = ((alto - medida) * 100) / alto;
      return resultado;
    }
if(porcent!=0){
  porcent=0.1;
}
    porcent = calcularPor(altura, distaan);
    double circular = porcent/100;
    // print("$circular lo que cargara en el circular");
    if (circular > 1) {
      circular = 1;
    }else if(circular <0.0){
      circular=0.0;
    }

    if(porcent<0){
      porcent=0.1;
    }
    // print("$porcent  porcenta de la medida ya calculada de la base ");

    if(altura>distaan){

if(porcent>(linearValue2*100.001)){
relay.update({'relay':0});
} 

if(porcent<(linearValue*100)){
relay.update({'relay':1});

}
    }

    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Center(
                child: Column(
              children: [
                const SizedBox(
                  width: 10,
                  height: 20,
                ),

                const Text(
                  "Estado del contenedor",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(249, 153, 153, 153),
                  ),
                ),

                // Porcentaje en círculo
                CircularPercentIndicator(
                  animateFromLastPercent: true,
                  radius: 100,
                  lineWidth: 20,
                  percent: circular,
                  center: Text(
                    "${porcent.toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 62),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.blue.shade100,
                  progressColor: Colors.blue,
                ),

                const SizedBox(
                  height: 70,
                ),
                statepomp(),
                const SizedBox(height: 70),
                Text(
                  "Encender con el contenido en: ${(linearValue * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 21),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("0%"),
                      GestureDetector(
                        onTapUp: (details) {
                          setState(() {
                            double tapPosition = details.localPosition.dx;
                            linearValue = tapPosition /
                                (MediaQuery.of(context).size.width - 120);
                            linearValue = linearValue.clamp(0.0, 1.0);
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            linearValue += details.delta.dx /
                                (MediaQuery.of(context).size.width - 100);
                            linearValue = linearValue.clamp(0.0, 1.0);
                            if (linearValue > linearValue2) {
                              linearValue2 = linearValue;
                              Fluttertoast.cancel();
                              showToast(
                                  message:
                                      "No sobreponer el porcentaje de encendido");
                            }
                          });
                        },
                        onPanEnd: (details){
                          try{
                          _saveLinearValues();
                          }catch (e){
                            print("no se guardo la configuracion del slider");                          }

                        },
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          animation: true,
                          animationDuration: 0,
                          lineHeight: 30,
                          percent: linearValue,
                          barRadius: const Radius.circular(100),
                          backgroundColor: Colors.blue.shade100,
                          progressColor: Colors.blue,
                        ),
                      ),
                      const Text("100%")
                    ],
                  ),
                ),
                Text(
                  "Apagar cuando este lleno al: ${(linearValue2 * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 21),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("0%"),
                      GestureDetector(
                        onTapUp: (details) {
                          setState(() {
                            double tapPosition = details.localPosition.dx;
                            linearValue2 = tapPosition /
                                (MediaQuery.of(context).size.width - 120);
                            linearValue2 = linearValue2.clamp(0.0, 1.0);
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            linearValue2 += details.delta.dx /
                                (MediaQuery.of(context).size.width - 100);
                            linearValue2 = linearValue2.clamp(0.0, 1.0);
                            if (linearValue > linearValue2) {
                              linearValue2 = linearValue;
                              Fluttertoast.cancel();
                              showToast(
                                  message:
                                      "No se puede estar debajo del porcentaje de encendido");
                            }
                          });
                        },
                          onPanEnd: (details){
                          try{
                          _saveLinearValues();
                          }catch (e){
                            print("no se guardo la configuracion del slider");
                          }
                        },
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          animation: true,
                          animationDuration: 0,
                          lineHeight: 30,
                          percent: linearValue2,
                          barRadius: const Radius.circular(100),
                          backgroundColor: Colors.blue.shade100,
                          progressColor: Colors.blue,
                        ),
                      ),
                      const Text("100%")
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                const SizedBox(
                  height: 80,
                )
              ],
            ))
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
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void openScreen(BuildContext context, int index) {
    late MaterialPageRoute ruta;
    switch (index) {
      case 0:
        ruta = MaterialPageRoute(
            builder: (context) => ContainerDetails(
                  imagePath: widget.imagePath,
                  title1: widget.title1,
                  title2: widget.title2,
                  height: widget.height,
                  id: widget.id,
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


  String estado(String dato) {
    if (dato == "1") {
      return 'Activado';
    } else {
      return 'Desactivado';
    }
  }

void apagarRele()async{
  if(porcent>(linearValue*100)){
    relay.update({"relay":0});
  } else {
    showToast(message:"No se puede apagar por el limite establecido");
  }

}
void prenderRele() async{
  if(porcent<(linearValue2*100)){
    relay.update({"relay":1});
  }else if(porcent>(linearValue2*100)){
    showToast(message: "se ha alcanzado limite de llenado ");
  }

  

}




  Column statepomp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Estado de la bomba: ${estado(getOnceValue)} ",
          style: const TextStyle(fontSize: 21),
        ),
        const SizedBox(
            height:
                20), // Agregar un espacio entre el texto y el indicador de progreso
        const SizedBox(
            height:
                20), // Agregar un espacio entre el indicador de progreso y los botones
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              onPressed: prenderRele
                  , // Llamar a la función para encender la bomba
              highlightColor: Colors.blue,
              splashColor: const Color.fromARGB(255, 33, 243, 226),
              color: Colors.blue,
              shape: const StadiumBorder(),
              child: const Text(
                'Encender',
                style: TextStyle(fontSize: 21),
              ),
            ),
            MaterialButton(
              onPressed:apagarRele
                  , // Llamar a la función para apagar la bomba
              highlightColor: Colors.blue,
              splashColor: const Color.fromARGB(255, 243, 159, 33),
              color: Colors.blue,
              shape: const StadiumBorder(),
              child: const Text(
                'Apagar',
                style: TextStyle(fontSize: 21),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
