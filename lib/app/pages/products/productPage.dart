import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/product.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final Product product;
  _ProductPageState(this.product);
  String selectedColor = "";

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: Theme.of(context).textTheme.subtitle,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((image) {
                return NetworkImage(image);
              }).toList(),
              dotSize: 4,
              dotSpacing: 20,
              dotBgColor: Colors.transparent,
              dotColor: primary,
              autoplay: false,
            ),
          ),
          Container(
            padding: EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: Text(
                    "R\$ ${product.price}",
                    style: TextStyle(fontSize: 25, color: Colors.blueAccent),
                  ),
                ),
                Divider(color: Colors.grey[800]),
                Text(
                  "Cores disponíveis:",
                  style: Theme.of(context).textTheme.display1,
                ),
                SizedBox(
                  height: 50,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.3),
                    children: product.colors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: selectedColor == color
                                    ? Colors.blueAccent
                                    : Colors.grey[500],
                              )),
                          alignment: Alignment.center,
                          child: Text(
                            color,
                            style: TextStyle(
                              fontSize: 15,
                              color: selectedColor == color
                                  ? Colors.blueAccent
                                  : Colors.grey[400],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey[500],
                      )),
                  height: 50,
                  child: RaisedButton(
                    onPressed: selectedColor != "" ? () {} : null,
                    child: Text(
                      "Faça login para comprar",
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                ),
                Text(
                  "Descrição:",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
