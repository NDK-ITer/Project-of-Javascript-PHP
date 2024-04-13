import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  Header({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
}
