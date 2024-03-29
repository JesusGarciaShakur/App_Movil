
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smca_application/Screens/notifications.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:smca_application/global/common/toast.dart';
import 'package:smca_application/sign_in_screen.dart';
import 'package:smca_application/theme/app_theme.dart';

class ContainerDetails extends StatefulWidget {
  final String imagePath;
  final String title1;
  final double title2;
  final double height;
  final int id;

  const ContainerDetails({
    required this.imagePath,
    required this.title1,
    required this.title2 ,
    required this.height,
    required this.id
  });

  @override
  _ContainerDetailsState createState() => _ContainerDetailsState();
}

class _ContainerDetailsState extends State<ContainerDetails> {


  final Future<FirebaseApp> _fApp = Firebase.initializeApp();


DatabaseReference relay= 
  FirebaseDatabase.instance
    .ref("usuarios/PJXMhNNDgFawm1WxVVidkPf4H5R2/datos/");
DatabaseReference relay2= 
  FirebaseDatabase.instance
    .ref("usuarios/PJXMhNNDgFawm1WxVVidkPf4H5R2/datos/relay");

//variable para guardar consulta del ultra
String altu="";
double distaan=0;
double porcent=0;
// variable para controlar el controlador dela barra
  double linearValue = 0.0;
  double linearValue2 = 0.8;
  // crear variable para  traer el tiempo
  

//consulta de altura
DatabaseReference typeContainer = 
  FirebaseDatabase.instance
    .ref("usuarios/PJXMhNNDgFawm1WxVVidkPf4H5R2/datos/ultrasonico");



//index del menu de abajo
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
if (_fApp !=null) {
  if (_fApp is Future<FirebaseApp>) {


  // consulta de la distancia
typeContainer.onValue.listen((event)async{
await Future.delayed(const Duration(seconds: 6)); 
   setState(() {
 Future.delayed(const Duration(seconds: 1)); 
    altu= event.snapshot.value.toString().trim();
  });
});
  
    
  }else {
    print("hubo error");
  }
}else{
print("cargando lo demas");
}

 

//get datos para mostrar en relacion del contenido 
double convertir([String valor ='0']) {
  try{
  double convertidor =double.parse(valor);
return convertidor;
  } catch (e){
return 0.0;
  }
}


relay2.onValue.listen((event) {
  setState((){
    getOnceValue= event.snapshot.value.toString();
  });
});

   distaan= convertir(altu);
  

 double altura =0;
 altura=widget.height;

double calcularPor(double altura, double medida){
double alto=altura;

double resultado=(medida*100)/alto;

  return resultado;
}

porcent=calcularPor(altura, distaan);
double circular=porcent/100;
  if(circular>1){
    circular=1;
  }

  if(porcent<(linearValue*100)){
    relay.update({"relay": 1});
                          } 

    if(porcent>(linearValue2*100)){
       relay.update({"relay": 0});
      }

    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Center(
              child: Column( children: [

         const SizedBox(width: 10,height: 20,),

         const Text(
              "Estado del contenededor",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(249, 153, 153, 153),
              ),
            ),

              // Porcentaje en circulo
               CircularPercentIndicator(
                animateFromLastPercent: true,                
                radius: 100,
                lineWidth: 20,
                percent: circular,
                center: Text("${porcent.toStringAsFixed(0)}%",
                style: const TextStyle(fontSize: 62),),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.blue.shade100,
                progressColor: Colors.blue,),

         const SizedBox(height: 70,),

  statepomp(),

         const SizedBox(height: 70),
              Text(
                "Encender con el contenido en: ${(linearValue * 100).toStringAsFixed(0)}%",
                style: TextStyle(fontSize: 21),),
        Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("0%"),
                  GestureDetector(
                    onTapUp: (details) {
                      double tapPosition = details.localPosition.dx;
                      linearValue = tapPosition /
                          (MediaQuery.of(context).size.width - 120);
                      setState(() {
                        linearValue = linearValue.clamp(0.0, 1.0);
                      });
                    },
                    onPanUpdate: (details) {
                      linearValue += details.delta.dx /
                          (MediaQuery.of(context).size.width - 100);
                      setState(() {
                        if (linearValue < 0) {
                          linearValue = 0.0;
                        } else if (linearValue > 1) {
                          linearValue = 1;
                        }
                         if(linearValue>linearValue2){
                            linearValue2=linearValue;
                            Fluttertoast.cancel();
                            showToast(message: "No sobreponer el porcentaje de encendido");
                          }
                      });
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
                style: const TextStyle(fontSize: 21),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("0%"),
                  
                  GestureDetector(
                    onTapUp: (details) {
                      double tapPosition = details.localPosition.dx;
                      linearValue2 = tapPosition /
                          (MediaQuery.of(context).size.width - 120);
                      setState(() {
                        linearValue2 = linearValue2.clamp(0.0, 1.0);
                      });
                    },
                    onPanUpdate: (details) {
                      linearValue2 += details.delta.dx /
                          (MediaQuery.of(context).size.width - 100);
                      setState(() {
                        if (linearValue2 < 0) {
                          linearValue2 = 0.0;
                        } else if (linearValue2 > 1) {
                          linearValue2 = 1;
                        }
                          if(linearValue2<linearValue){
                            linearValue2=linearValue;
                            Fluttertoast.cancel();
                            showToast(message: "No se puede estar debajo el porcentaje de encendido ");
                          
                          }

  
                      });
                    },
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 100,
                      animation: true,
                      animationDuration: 0,
                      lineHeight: 30,
                      percent: linearValue2,
                      barRadius: const Radius.circular(100),
                      backgroundColor: Colors.blue.shade100,
                      progressColor: Colors.blue
                    ),
                  ),
                  const Text("100%")
                ],
              ),
            ),
         const SizedBox(height: 30),
            

            const SizedBox(height: 80,)

              ],)
            )

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
        ruta = MaterialPageRoute(builder: (context) =>  ContainerDetails(
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

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.imagePath),

          const SizedBox(height: 20),
          Text("${widget.title2.toStringAsFixed(0)} litros"),

          const SizedBox(height: 20),
          Text('Altura: ${widget.height.toStringAsFixed(0)} cm'),

          const SizedBox(height: 20),
          Text('id: ${widget.id.toString()}'),
          ElevatedButton(
            onPressed: () {
              final ruta1= MaterialPageRoute(builder:(context){
                  return const SignIn();
                });
                Navigator.push(context, ruta1);
            },
            child: Text('Elegir otro contenedor'),
          ),
        ],
      ),
    );
  }



String getOnceValue="";
String estado(String dato){
if(dato=="1"){
  return'Activado';
}else{
  return 'Desactivado';
}
}



Column statepomp(){
  return  Column(
    mainAxisAlignment:  MainAxisAlignment.center,
    children: [
        Text("Estado de la bomba: ${estado(getOnceValue)} ",style: const TextStyle(fontSize: 21),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [MaterialButton(

          onPressed:() async {
            
            Future.delayed(const Duration(seconds: 2)); 
            relay.update({"relay": 1});
         
          },
          highlightColor: Colors.blue,
          splashColor:  const Color.fromARGB(255, 33, 243, 226),
          color:  Colors.blue,
          shape: const StadiumBorder(),
          child:const Text('Encender',style: TextStyle(fontSize: 21),),
          
          ),
        MaterialButton(
          onPressed:()async {
            Future.delayed(const Duration(seconds: 1)); 
    relay.update({"relay": 0});
         

          },
          highlightColor: Colors.blue,
          splashColor:const Color.fromARGB(255, 243, 159, 33),
          color:  Colors.blue,
          shape: const StadiumBorder(),
          child:const Text('Apagar',style: TextStyle(fontSize: 21),),
          
          ),
          ],
      )
    ],
  );
}




}
