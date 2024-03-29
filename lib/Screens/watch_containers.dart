import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class WatchContainers extends StatefulWidget {
  const WatchContainers({Key? key}) : super(key: key);

  @override
  State<WatchContainers> createState() => _WatchContainersState();
}

class _WatchContainersState extends State<WatchContainers> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String reaLTimeValue = '0';
  String getOnceValue = "0";

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    DatabaseReference _testRef = FirebaseDatabase.instance
        .reference()
        .child("usuarios")
        .child(user?.uid ?? '') // Utiliza el UID del usuario actual
        .child('datos')
        .child('ultrasonico');

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
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                future: _fApp,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Algo salió mal con Firebase");
                  } else if (snapshot.hasData) {
                    return const Text("Firebase está inicializado");
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              GestureDetector(
                onTap: () async {
                  final snapshot = await _testRef.get();
                  if (snapshot.exists) {
                    setState(() {
                      getOnceValue = snapshot.value.toString();
                    });
                  } else {
                    print("No hay información disponible");
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text("Soy otro botón")),
                ),
              ),
              buildContainerWithIndicator(
                  'Segundo Contenedor getonce $getOnceValue', context),
              buildContainerWithIndicator(
                  'Tercer Contenedor realtime $reaLTimeValue', context),
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
