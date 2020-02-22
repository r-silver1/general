//import material class
import 'package:flutter/material.dart';
//import packages: get data for cryptocurrency prices
/*asynchronous programming: send processes to different threads to not overwhelm
 *the main thread; useable get future objects i.e. https request returns
 */
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


//unApp calls MyApp
void main() => runApp(MyApp());

//stateless class; immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    //build: display context on screen using context of parent, widget tree
    //MaterialApp: from material class, premande components i.e.  theme, body
    return MaterialApp(
      title: 'Crypto Price List',
      /*not sure why made a new ThemeData vs. just ThemeData but ok. note: not
       *extending default theme making whole new one? other examples use a theme
       * variable
       * https://gist.github.com/mikemimik/5ac2fa98fe6d132098603c1bd40263d5
       */
      theme: new ThemeData(
          primaryColor: Colors.orange,
      ),

      /*Center: center child within itself; constrained: big as possible if
       *widthFactor and heightFactor null. dimension unconcstrained, widget
       * match child's size
       * https://api.flutter.dev/flutter/widgets/Center-class.html
       */

      home: CryptoList(),

    );
  }
}

//create stateful widget (DATA WILL CHANGE)
//called from MaterialApp home()
class CryptoList extends StatefulWidget {
  @override
  //basic widget, just call state creation each time
  CryptoListState createState() => CryptoListState();
}

/* Stateful widgets maintain state that might change during lifetime of the widget
 *  -two classes
 *  -StatefulWidget creates instance State class
 *    -Cryptolist creates CryptoListState
 *  -StatefulWidget class is itself, immutable
 *    -State class, persists over lifetime, widget
 *    -most logic: just create state class
 */

class CryptoListState extends State<CryptoList>{


  //use later: favorited cryptos
  void _pushSaved() {}

  //build method
    @override
    Widget build(BuildContext context) {
      /* material class scaffold, API show drawers, snack
       * bars, bottom sheets
       * general: describe how widget looks
       */
      return Scaffold(
        appBar: AppBar(
          title: Text('CryptoList'),
          actions: <Widget>[
            //use material icons build button to view favorites
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: new Center(
          //body of scaffold; same as what we had before implementing cryptoList
          child: new Text('my crypto app'),
        )
      );
    }
}



