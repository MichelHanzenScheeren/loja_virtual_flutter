import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/widgets/degradeBack.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Color> colors = [
    Color.fromARGB(255, 15, 15, 15),
    Color.fromARGB(255, 30, 30, 30)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  title: const Text("Novidades"),
                  centerTitle: true,
                ),
              ),
              FutureBuilder<List>(
                future: Database.instance.getHomeProducts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: WaitingWidget(),
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
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: document.data["image"],
                          fit: BoxFit.cover,
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
    );
  }
}
