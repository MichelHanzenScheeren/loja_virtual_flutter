import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/widgets/categoryButton.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: Database.instance.getProductsCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return WaitingWidget();
        } else {
          return ListView(
            children: ListTile.divideTiles(
              tiles: snapshot.data.map((category) {
                return CategoryButton(category);
              }).toList(),
              color: Colors.grey[700],
            ).toList(),
          );
        }
      },
    );
  }
}
