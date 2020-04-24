import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    @required VoidCallback onSucess,
    @required VoidCallback onFail,
  }) {
    setLoading(true);
    auth
        .createUserWithEmailAndPassword(email: data.email, password: password)
        .then((user) async {
      currentUser = user;
      userData = data;
      await Database.instance.saveUserData(currentUser.uid, data);
      onSucess();
      setLoading(false);
    }).catchError(
      (error) {
        onFail();
        setLoading(false);
      },
    );
  }

  void setLoading(bool change) {
    isLoading = change;
    notifyListeners();
  }

  void logIn() {}

  void logOut() {}

  void recoverPassword() {}

  bool isLogged() {
    return false;
  }
}
