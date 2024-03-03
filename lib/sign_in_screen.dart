import 'package:flutter/material.dart';
import 'package:smca_application/Screens/add_container.dart';
import 'package:smca_application/Screens/contact_us.dart';
import 'package:smca_application/Screens/notifications.dart';
import 'package:smca_application/Screens/profile.dart';
import 'package:smca_application/Screens/report_problem.dart';
import 'package:smca_application/Screens/watch_containers.dart';
import 'package:smca_application/Screens/water_pump.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Contenedores'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Agregar contenedor'),
            subtitle: const Text('Añadir nuevo contenedor a aplicacion'),
            leading: const Icon(
              Icons.dashboard_customize_outlined,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta1 = MaterialPageRoute(builder: (context) {
                return const AddContainer();
              });
              Navigator.push(context, ruta1);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Ver mis contenedores',
            ),
            subtitle: const Text(
              'Administrar los contedores disponibles',
            ),
            leading: const Icon(
              Icons.brunch_dining_rounded,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta2 = MaterialPageRoute(builder: (context) {
                return const WatchContainers();
              });
              Navigator.push(context, ruta2);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Progrmamar bomba',
            ),
            subtitle: const Text(
              'Administar el encendido y pagado de bomba',
            ),
            leading: const Icon(
              Icons.power_settings_new_outlined,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta3 = MaterialPageRoute(builder: (context) {
                return const WaterPump();
              });
              Navigator.push(context, ruta3);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Notificaciones',
            ),
            subtitle: const Text(
              'Ver y administrar tus notificaciones',
            ),
            leading: const Icon(
              Icons.circle_notifications_outlined,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta4 = MaterialPageRoute(builder: (context) {
                return const Notifications();
              });
              Navigator.push(context, ruta4);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Perfil',
            ),
            subtitle: const Text(
              'Configura y administra tu perfil',
            ),
            leading: const Icon(
              Icons.account_circle_outlined,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta5 = MaterialPageRoute(builder: (context) {
                return const Profile();
              });
              Navigator.push(context, ruta5);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Reportar un problema',
            ),
            subtitle: const Text(
              'Reportar un problema respecto a tu dispositivo SMCA',
            ),
            leading: const Icon(
              Icons.perm_device_information_rounded,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta6 = MaterialPageRoute(builder: (context) {
                return const ReportProblem();
              });
              Navigator.push(context, ruta6);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Contactanos',
            ),
            subtitle: const Text(
              'Contactanos por medio de nuestras redes y numeros de ayuda',
            ),
            leading: const Icon(
              Icons.call,
            ),
            trailing: const Icon(
              Icons.double_arrow_rounded,
            ),
            onTap: () {
              final ruta7 = MaterialPageRoute(builder: (context) {
                return const ContactUs();
              });
              Navigator.push(context, ruta7);
            },
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Majestic',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          )
        ],
      ),
    );
  }
}
