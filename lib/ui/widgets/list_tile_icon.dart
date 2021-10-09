import 'package:flutter/material.dart';

Widget buildListTileIcon(Widget icon) {
  return Container(
    width: 36,
    height: 24,
    alignment: Alignment.centerRight,
    child: icon,
  );
}

Widget buildBulletPoint() {
  return buildListTileIcon(ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Container(
      width: 5,
      height: 5,
      child: ColoredBox(color: Colors.black),
    ),
  ));
}
