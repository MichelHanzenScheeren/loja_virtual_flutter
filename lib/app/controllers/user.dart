import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/client.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  Client userData;
  bool isLoading = false;

  void createAccount({
    @required Client data,
    @required String password,
    @required Function onSucess,
    @required Function onFail,
  }) {
    setLoading(true);
    auth
        .createUserWithEmailAndPassword(email: data.email, password: password)
        .then((user) async {
      currentUser = user;
      userData = data;
      await onSucess();
      await Database.instance.saveUserData(currentUser.uid, data);
      setLoading(false);
    }).catchError(
      (error) {
        onFail(error);
        setLoading(false);
      },
    );
  }

  void setLoading(bool change) {
    isLoading = change;
    notifyListeners();
  }

  bool isLogged() {
    return currentUser != null;
  }

  String getName() => userData.name;

  void logIn() {}

  void logOut() async {
    await auth.signOut();
    userData = null;
    currentUser = null;
    notifyListeners();
  }

  void recoverPassword() {}
}
