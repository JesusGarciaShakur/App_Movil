import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//firebase paquete
import 'package:firebase_core/firebase_core.dart';

class WatchContainers extends StatefulWidget {
  const WatchContainers({super.key});

  @override
  State<WatchContainers> createState() => _WatchContainersState();
}

class _WatchContainersState extends State<WatchContainers> {
// variable de resolucion de data base
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();

  String reaLTimeValue = '0';
  String getOnceValue = "0";

  @override
  Widget build(BuildContext context) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref("Sensor").child('ultrasonico');

    _testRef.onValue.listen((event) {
      setState(() {
        reaLTimeValue = event.snapshot.value.toString();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Contenedores'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // Ancho de la pantalla
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                  future: _fApp,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("algo salio mal con firebase");
                    } else if (snapshot.hasData) {
                      return const Text("firebase esta inicializado");
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              GestureDetector(
                onTap: () async {
                  // obtener el valor una vez de firebase
                  final snapshot = await _testRef.get();
                  if (snapshot.exists) {
                    setState(() {
                      getOnceValue = snapshot.value.toString();
                    });
                  } else {
                    print("no hay informacion disponible");
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("soy otro boton")),
                ),
              ),

              buildContainerWithIndicator(
                  'Segundo Contenedor getonce $getOnceValue', context),
              buildContainerWithIndicator(
                  'Tercer Contenedor realtime $reaLTimeValue', context),
              // Agrega más contenedores si es necesario
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerWithIndicator(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 4, 171, 243),
        border: Border.all(
          color: const Color.fromARGB(221, 71, 71, 71),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // const Image(
          //     image: NetworkImage(
          //         'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',)),
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
              width:
                  35), // Espacio entre el CircularProgressIndicator y el texto
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
