import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/cartProduct.dart';
import 'package:lojavirtualflutter/app/models/client.dart';
import 'package:lojavirtualflutter/app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  Client userData;
  bool isLoading = false;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  static User of(BuildContext context) => ScopedModel.of<User>(context);

  Future _loadCurrentUser() async {
    if (currentUser == null) {
      currentUser = await auth.currentUser();
    }
    if (currentUser != null) {
      userData = await Database.instance.getUserData(currentUser.uid);
    }
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

  void setLoading(bool change) {
    isLoading = change;
    notifyListeners();
  }

  bool isLogged() => currentUser != null;

  String getName() => userData.name;

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
    notifyListeners();
  }

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

  void addToCart({
    @required Product product,
    @required String selectedColor,
    @required Function onSucess,
    @required Function onFail,
  }) async {
    CartProduct cartProduct = CartProduct(
      productUid: product.id,
      categoryUid: product.category,
      quantity: 1,
      color: selectedColor,
    );
    setLoading(true);
    Database.instance.addCartItem(currentUser.uid, cartProduct).then((_) {
      onSucess();
      setLoading(false);
    }).catchError((error) {
      onFail(error);
      setLoading(false);
    });
  }
}
