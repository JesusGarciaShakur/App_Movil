
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WaterPump extends StatefulWidget {
  const WaterPump({super.key});

  @override
  State<WaterPump> createState() => _WaterPumpState();
}

class _WaterPumpState extends State<WaterPump> {
  // variable para controlar el controlador dela barra
double linearValue= 0.5;
double linearValue2= 0.5;



// crear variable para  traer el tiempo
TimeOfDay _timeOfDay =const  TimeOfDay(hour: 8, minute: 30);

  // metodo para obtener tiempo 
  void _showTimePicker (){
    showTimePicker(
      context: context,
     initialTime: TimeOfDay.now()
     ).then((value) {
      setState(() {
        _timeOfDay=value!;
      });
     });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              appBar: AppBar(
                title: const Text("encendido de bomba"),
                            ),
              body:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                     const Text("configurar hora de encenido",
                            style: TextStyle(
                                    fontSize: 28,
                                    color: Color.fromARGB(249, 153, 153, 153)
                                    )
                            ),

                    Text(_timeOfDay.format(context).toString(),
                      style:const TextStyle(fontSize: 57)),

                    MaterialButton(
                      onPressed:_showTimePicker,
                      child:const Text("un boton")
                      ),

                    Text("Encender con el contenido en: ${(linearValue*100).toStringAsFixed(0)}%"),
                    Padding(
                      padding: const EdgeInsets.all(20.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("0%"),
                          GestureDetector(
                              onTapUp: (details) {
                              double tapPosition = details.localPosition.dx;
                                linearValue = tapPosition / (MediaQuery.of(context).size.width-120);
                              setState(() {
                                    linearValue = linearValue.clamp(0.0, 1.0);
                                          }
                                      );
                              },
                               onPanUpdate: (details) {
                                    linearValue += details.delta.dx / (MediaQuery.of(context).size.width - 100);
                                  setState(() {
                                    if (linearValue < 0) {
                                      linearValue = 0.0;
                                    } else if (linearValue > 1) {
                                      linearValue = 1;
                                    }
                                  });
                                },

                                child:LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width-100,
                                animation: true,
                                animationDuration: 0,
                                lineHeight: 30,
                                percent: linearValue,
                                barRadius: const Radius.circular(100),
                                progressColor: const Color.fromARGB(255, 169, 160, 190),
                              ),

                          ),
                          const Text("100%")
                        ],
                      ),

                    ),



                          // la segunda barra de control 
                     Text("apagar cuando este lleno al: ${(linearValue2*100).toStringAsFixed(0)}%"),
                      Padding(
                      padding: const EdgeInsets.all(20.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("0%"),
                          GestureDetector(
                              onTapUp: (details) {
                              double tapPosition = details.localPosition.dx;
                                linearValue2 = tapPosition / (MediaQuery.of(context).size.width-120);
                              setState(() {
                                    linearValue2 = linearValue2.clamp(0.0, 1.0);
                                          }
                                      );
                              },
                               onPanUpdate: (details) {
                                    linearValue2 += details.delta.dx / (MediaQuery.of(context).size.width - 100);
                                  setState(() {
                                    if (linearValue2 < 0) {
                                      linearValue2 = 0.0;
                                    } else if (linearValue2 > 1) {
                                      linearValue2 = 1;
                                    }
                                  });
                                },

                                child:LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width-100,
                                animation: true,
                                animationDuration: 0,
                                lineHeight: 30,
                                percent: linearValue2,
                                barRadius: const Radius.circular(100),
                                progressColor: const Color.fromARGB(255, 169, 160, 190),
                              ),

                          ),
                          const Text("100%")
                        ],
                      ),
                    ),

                        const MaterialButton(
                          onPressed:null,
                          child:Text("Guardar")
                        )
                  ],
                ),
              )

    );
  }
}
