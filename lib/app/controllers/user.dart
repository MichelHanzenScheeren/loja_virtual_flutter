import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  Map<String, dynamic> userData;
  bool isLoading = false;

  void logIn() {
    isLoading = true;
    notifyListeners();
  }

  void logOut() {

  }

  void recoverPassword() {

  }

  bool isLogged() {
    return false;
  }
}