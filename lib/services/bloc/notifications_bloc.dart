import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsInitial()) {
    _onForegroundMessage();
    _onBackgroundMessage();
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleRemoteMessage(message);
    });
  }

  void _onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      // Procesar la notificación en segundo plano
      print("Notificación en segundo plano recibida: ${message.data}");
    });
  }

  void handleRemoteMessage(RemoteMessage message) {
    var mensaje = message.data;
    var body = mensaje['body'];
    var title = mensaje['title'];
    // Aquí puedes mostrar la notificación utilizando Fluttertoast, showDialog o cualquier otro método que prefieras
    // Por ejemplo:
    Fluttertoast.showToast(
        msg: "$title: $body",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    // TODO: Implementar lógica de eventos si es necesario
  }
}
