import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final categoria;
  CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(categoria["icon"]),
      ),
      title: Text(categoria["title"]),
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white70,),
      onTap: () {},
    );
  }
}
