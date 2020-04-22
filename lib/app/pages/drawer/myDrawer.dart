import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/drawer/drawerItem.dart';
import 'package:lojavirtualflutter/app/pages/user/login/login.dart';
import 'package:lojavirtualflutter/app/widgets/degradeBack.dart';

class MyDrawer extends StatelessWidget {
  final PageController pageController;
  MyDrawer(this.pageController);

  final List<Color> colors = [
    Color.fromARGB(255, 40, 40, 40),
    Color.fromARGB(255, 30, 30, 30),
    Color.fromARGB(255, 20, 20, 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          DegradeBack(colors, Alignment.topCenter, Alignment.bottomCenter),
          ListView(
            padding: EdgeInsets.only(left: 35, top: 60),
            children: <Widget>[
              Container(
                height: 160,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        "Mixéus'\nTechnologies",
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Olá,",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login()));
                            },
                            child: Text(
                              "Entre ou cadastre-se >",
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: <Widget>[
                    DrawerItem(Icons.home, "Início", pageController, 0),
                    DrawerItem(Icons.list, "Produtos", pageController, 1),
                    DrawerItem(Icons.location_on, "Lojas", pageController, 2),
                    DrawerItem(Icons.playlist_add_check, "Meus pedidos",
                        pageController, 3),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
