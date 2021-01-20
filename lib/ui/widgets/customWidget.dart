import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  static drawerWidget(
      {BuildContext context, String text, VoidCallback onPressed}) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color(0xffce0d1e),
            width: MediaQuery.of(context).size.width,
            child: Text(
              text[0].toUpperCase() + text.substring(1).toLowerCase(),
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: 1,
        )
      ],
    );
  }

  static drawerWidgetWithIcon(
      {BuildContext context, String text, VoidCallback onPressed}) {
    return Column(
      children: <Widget>[
        InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    color: Color(0xffce0d1e),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      text[0].toUpperCase() + text.substring(1).toLowerCase(),
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: 1,
        )
      ],
    );
  }
}
