
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WaterPump extends StatefulWidget {
  const WaterPump({super.key});

  @override
  State<WaterPump> createState() => _WaterPumpState();
}

class _WaterPumpState extends State<WaterPump> {
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

                        // CircularPercentIndicator(
                        //   animation: true,
                        //   animationDuration: 1000,
                        //   radius: 100,
                        //   lineWidth: 20,
                        //   percent: .5,
                        //   progressColor: const Color.fromARGB(255, 131, 232, 231),
                        //   backgroundColor: const Color.fromARGB(249, 157, 181, 178),
                        //   circularStrokeCap: CircularStrokeCap.round,
                        //   center: const Text("50%",style: TextStyle(fontSize: 60)),
                        //  ),

                        const Text("apagar con el porcentaje en "),
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30,
                          percent: 0.5,
                          progressColor: const Color.fromARGB(255, 169, 160, 190),
                          
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
