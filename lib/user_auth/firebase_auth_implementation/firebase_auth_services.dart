import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; // Importa la librería de Firebase Realtime Database
import 'package:smca_application/global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _userRef = FirebaseDatabase.instance.reference().child(
      'usuarios'); // Referencia a la colección 'usuarios' en la base de datos

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String nombre) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Agrega el nombre de usuario a la base de datos
      await _userRef.child(credential.user!.uid).set({
        'nombre': nombre,
        'correo': email,
        // Puedes agregar otros campos aquí si es necesario
      });
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: "El correo ya se está usando");
      } else {
        showToast(message: "Ha ocurrido un error : ${e.code}");
      }
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: "Correo invalido o contraseña");
      } else {
        showToast(message: "a ocurrido un error : ${e.code}");
      }
    }
    return null;
  }
}
