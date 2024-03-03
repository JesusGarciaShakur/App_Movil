import 'package:flutter/material.dart';

class WatchContainers extends StatelessWidget {
  const WatchContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Contenedores'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width, // Ancho de la pantalla
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildContainerWithIndicator('Primer Contenedor', context),
                buildContainerWithIndicator('Segundo Contenedor', context),
                buildContainerWithIndicator('Tercer Contenedor', context),
                // Agrega más contenedores si es necesario
              ],
            ),
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
