import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/widgets/degradeBack.dart';

class Home extends StatelessWidget {
  final drawer;
  final cartButton;
  Home(this.drawer, this.cartButton);

  final List<Color> colors = [
    Color.fromARGB(255, 15, 15, 15),
    Color.fromARGB(255, 30, 30, 30)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: cartButton,
      drawer: drawer,
      body: Stack(
        children: <Widget>[
          DegradeBack(colors, Alignment.topLeft, Alignment.bottomRight),
          Container(
            color: Color.fromARGB(240, 30, 30, 30),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Novidades",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    centerTitle: true,
                  ),
                ),
                FutureBuilder<List>(
                  future: Database.instance.getHomeProducts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SliverToBoxAdapter(
                        child: WaitingWidget(
                          width: 100,
                          height: 100,
                        ),
                      );
                    } else {
                      return SliverStaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        staggeredTiles: snapshot.data.map((document) {
                          return StaggeredTile.count(
                              document.data["x"], document.data["y"]);
                        }).toList(),
                        children: snapshot.data.map((document) {
                          return Image.network(
                            document.data["image"],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return WaitingWidget(width: 50, height: 50);
                              }
                            },
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
