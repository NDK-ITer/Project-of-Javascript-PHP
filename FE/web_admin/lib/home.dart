import 'package:flutter/material.dart';
import 'package:web_admin/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: Center(
        child: Row(
          children: [
            Expanded(flex: 1, child: SidebarWidget()),
            Expanded(flex: 5, child: Container()),
          ],
        ),
      ),
    );
  }
}
