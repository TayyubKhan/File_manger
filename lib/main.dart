import 'package:filemanager/Provider.dart';
import 'package:filemanager/Screens/SplashScreen.dart';
import 'package:filemanager/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/tenp.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => SelectionProvider(),
        child:    const MaterialApp(
            title: 'Flutter Demo',
            home: SplashScreen())
    );
  }

}
