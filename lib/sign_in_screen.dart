import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Contenedores'),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            title: Text('Agregar contenedor'),
            subtitle: Text('Añadir nuevo contenedor'),
            leading: Icon(
              Icons.dashboard_customize_outlined,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
            //Aqui añadir el on tap
          ),
          Divider(),
          ListTile(
            title: Text(
              'Ver mis contenedores',
            ),
            subtitle: Text(
              'Administrar los contedores disponibles',
            ),
            leading: Icon(
              Icons.brunch_dining_rounded,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Progrmamar bomba',
            ),
            subtitle: Text(
              'Administar el encendido y pagado de bomba',
            ),
            leading: Icon(
              Icons.power_settings_new_outlined,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Notificaciones',
            ),
            subtitle: Text(
              'Ver y administrar tus notificaciones',
            ),
            leading: Icon(
              Icons.circle_notifications_outlined,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Perfil',
            ),
            subtitle: Text(
              'Configura y administra tu perfil',
            ),
            leading: Icon(
              Icons.account_circle_outlined,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Reportar un problema',
            ),
            subtitle: Text(
              'Reportar un problema respecto a tu dispositivo SMCA',
            ),
            leading: Icon(
              Icons.perm_device_information_rounded,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Contactanos',
            ),
            subtitle: Text(
              'Contactanos por medio de nuestras redes y numeros de ayuda',
            ),
            leading: Icon(
              Icons.call,
            ),
            trailing: Icon(
              Icons.double_arrow_rounded,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Majestic',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            //style: Align(alignment: Alignment.topRight),
          )
        ],
      ),
    );
  }
}
