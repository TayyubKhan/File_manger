import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
class Temporary_Screen extends StatefulWidget {
  Temporary_Screen({Key? key}) : super(key: key);

  @override
  State<Temporary_Screen> createState() => _Temporary_ScreenState();
}

class _Temporary_ScreenState extends State<Temporary_Screen> {
  @override
  Widget build(BuildContext context) {
    void gettingpermision() async {

      PermissionStatus status ;
      if(await Permission.storage.status==false)
        {
          Map<Permission, PermissionStatus> statuses =
          await [Permission.storage].request();

        }
      }

    return Scaffold(
      body: Center(child: Container(
        color: Colors.teal,
        width: 100,
        height: 30,
        child: const Center(child: Text("Button")),
      ),)
    );
  }
}
