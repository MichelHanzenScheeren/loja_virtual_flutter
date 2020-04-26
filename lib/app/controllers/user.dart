import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<CartProduct> cartProducts;
  Map<String, dynamic> coupon;
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
      cartProducts = await Database.instance.getCartProducts(currentUser.uid);
    }
    setLoading(false);
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

  int cartProductsCount() {
    if (cartProducts == null) {
      return 0;
    } else {
      return cartProducts.fold(0, (sum, item) {
        return item.quantity + sum;
      });
    }
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
    cartProducts = null;
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
    setLoading(true);
    CartProduct item = findCartProduct(product.id, selectedColor);
    if (item == null) {
      CartProduct cartProduct = CartProduct(
        productUid: product.id,
        categoryUid: product.category,
        quantity: 1,
        color: selectedColor,
      );

      Database.instance.newCartItem(currentUser.uid, cartProduct).then((uid) {
        cartProduct.cartUid = uid;
        if (cartProducts == null) {
          cartProducts = List<CartProduct>();
        }
        cartProducts.add(cartProduct);
        sucess(onSucess);
      }).catchError((error) {
        fail(onFail, error);
      });
    } else {
      item.quantity += 1;
      Database.instance.updateCartItemQuantity(currentUser.uid, item).then((_) {
        sucess(onSucess);
      }).catchError((error) {
        fail(onFail, error);
      });
    }
  }

  CartProduct findCartProduct(String productId, String color) {
    return cartProducts?.firstWhere((item) {
      return item.productUid == productId && item.color == color;
    }, orElse: () => null);
  }

  void sucess(Function onSucess) {
    onSucess();
    setLoading(false);
  }

  void fail(Function onFail, dynamic error) {
    onFail(error);
    setLoading(false);
  }

  void removeFromCart(CartProduct cartProduct) {
    Database.instance.removeFromCart(currentUser.uid, cartProduct.cartUid);
    cartProducts.remove(cartProduct);
    notifyListeners();
  }

  void modifyCartProductQuantity(int num, CartProduct cartProduct) {
    cartProduct.quantity += num;
    Database.instance.updateCartItemQuantity(currentUser.uid, cartProduct);
    notifyListeners();
  }

  Future<bool> submitCoupom(String text) async {
    coupon = await Database.instance.getCoupom(text);
    return coupon != null;
  }
}
