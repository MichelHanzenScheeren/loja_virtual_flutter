import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/order/orders.dart';
import 'package:lojavirtualflutter/app/widgets/myOkButton.dart';

class SucessOrder extends StatelessWidget {
  final String orderUid;
  SucessOrder(this.orderUid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.done,
              size: 120,
              color: Color.fromARGB(220, 21, 152, 21),
            ),
            SizedBox(height: 20),
            Text(
              "Pedido finalizado, ${User.of(context)?.userData?.name ?? "obrigado"}!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 5),
            Text(
              "Código: $orderUid",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 25),
            MyOkButton("Ver meus pedidos", Theme.of(context).textTheme.body1,
                () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Orders()),
              );
            }),
          ],
        ),
      ),
    );
  }
}
