//import material class
import 'package:flutter/material.dart';

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
          primaryColor: Colors.white
      ),

      /*Center: center child within itself; constrained: big as possible if
       *widthFactor and heightFactor null. dimension unconcstrained, widget
       * match child's size
       * https://api.flutter.dev/flutter/widgets/Center-class.html
       */

      home: new Center(
          child: new Text('my crypto app')
      ),
    );
  }
}