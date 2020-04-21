import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/product.dart';
import 'package:lojavirtualflutter/app/pages/products/productItem.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class ProductsList extends StatelessWidget {
  final category;
  ProductsList(this.category);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            category["title"],
            style: Theme.of(context).textTheme.subtitle,
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Theme.of(context).hintColor,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: FutureBuilder<List<Product>>(
          future: Database.instance.getProductsList(category["id"]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return WaitingWidget();
            } else {
              return buildTabs(snapshot.data);
            }
          },
        ),
      ),
    );
  }

  Widget buildTabs(List<Product> data) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        gridTab(data),
        listTab(data),
      ],
    );
  }

  Widget gridTab(List<Product> data) {
    return GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.65, //relação largura/altura de cada item
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ProductItem("grid", data[index]);
        });
  }

  Widget listTab(List<Product> data) {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ProductItem("list", data[index]);
        }
    );
  }
}
