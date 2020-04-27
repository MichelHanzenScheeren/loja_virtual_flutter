import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualflutter/app/controllers/CartController.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/client.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  Client userData;
  CartController cart;
  bool isLoading = false;

  static User of(BuildContext context) => ScopedModel.of<User>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  Future _loadCurrentUser() async {
    setLoading(true);
    if (currentUser == null) {
      currentUser = await auth.currentUser();
    }
    if (currentUser != null) {
      userData = await Database.instance.getUserData(currentUser.uid);
      cart = CartController(currentUser, notifyListeners, setLoading);
      await cart.getCartProducts(currentUser.uid);
    }
    setLoading(false);
  }

  void setLoading(bool change) {
    isLoading = change;
    notifyListeners();
  }

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

  void logIn({
    @required String email,
    @required String password,
    @required Function onSucess,
    @required Function onFail,
  }) {
    setLoading(true);
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      currentUser = user;
      await _loadCurrentUser();
      await onSucess(userData.name);
      setLoading(false);
    }).catchError(
      (error) {
        currentUser = null;
        userData = null;
        onFail(error);
        setLoading(false);
      },
    );
  }

  void logOut() async {
    await auth.signOut();
    userData = null;
    currentUser = null;
    cart.cartProducts = null;
    notifyListeners();
  }

  bool isLogged() => currentUser != null;

  String getName() => userData.name;

  Future recoverPassword(
    String email,
    Function onSucess,
    Function onFail,
  ) async {
    setLoading(true);
    await auth.sendPasswordResetEmail(email: email).then((_) {
      setLoading(false);
      onSucess();
    }).catchError((error) {
      setLoading(false);
      onFail(error);
    });
  }
}
