import 'dart:async';

import 'package:filemanager/cosnt.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    setState(() {

    });
    Timer(const Duration(seconds: 5), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()) ));
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: darkcolorr,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: const Center(child: Image(image: AssetImage('images/filemanager.png'))

                  )),
            ),
             const Text('File Manager',style: TextStyle(color: Colors.amber,fontSize: 60,fontWeight: FontWeight.bold),),
             SizedBox(height: MediaQuery.of(context).size.height*0.09,),
            Column(
               children: [
                Reuseabletext(name: 'Tayyub Khan'),
               ],
             )
          ],
        ),
      ),
    );
  }
}

class Reuseabletext extends StatelessWidget {
 final String name;
   Reuseabletext({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name:',style:const TextStyle(color: textcollor))
        ],
      ),
    );
  }
}
