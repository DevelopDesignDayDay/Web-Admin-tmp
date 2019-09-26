import '../utills/responsiveLayout.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final navLinks = ["All", "AOS", "iOS", "Backend", "Designer"];

  List<Widget> navItem() {
    return navLinks.map((text) {
      return Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(text, style: TextStyle(fontFamily: "Montserrat-Bold")));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.black38],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft)),
                child: Center(
                  child: Text(
                    "D",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text("3기 관리자",
                  style: TextStyle(fontSize: 26, color: Colors.black))
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[...navItem()])
        ],
      ),
    );
  }
}
