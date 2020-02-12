// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
/*
 * Material: visual design language; flutter
 * has built in widgets
 */
void main() => runApp(MyApp());
/*
 *Arrow notation: used for one-line functions
 * or methods
 */

class MyApp extends StatelessWidget {
  /*
   *App extends StatelessWidget, makes app
   * a widget. Almost everything a widget, including
   * alignment, padding, layout
   *
   *
   */
  @override
  Widget build(BuildContext context){
    /* Widget: main purpose: provide
     * build() method: describe how to
     * display widget in terms other,
     * lower level widgets
     */
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        /* Scaffold: widget from material library
         * provides default app bar, title, and
         * body property
         * body: holds widget tree, home screen
         */
        appBar: AppBar(
          title: Text('Welcome to FLutter'),
        ),
        body: Center(
          /* Center: aligns widget subtree
           * to center of screen (children)
           */
          child: Text(wordPair.asPascalCase),
          //PascalCase: UpperCamelCase
        ),
      ),
    );
  }
}

/* States:
 * Stateless widgets: immutable: properties can't change, all values final
 * Stateful: maintain state: might change during lifetime of the widget;
 * requires two classes to be implemented:
 *   -StatefulWidget (immutable) class: Creates instance of...
 *   -State class: persists over lifetime of widget
 *
 * Next Step:
 * Add stateful widget, RandomWords
 *  -Child inside MyApp stateless widget
 *  -Creates State class, RandomWordsState
 */

class RandomWordsState extends State<RandomWords>{
  /* Declaration: State<RandomWords>
   *  -generic State<> class: specialized for use with "RandomWords"
   *  -app logic and state resides here: maintains state, RandomWords widget
   *  -Basic logic:
   *     --Save generated word pairs, grow infinitely
   *     --favorite word pairs: heart icon, user add/remove
   *  -RandomWordsState depends on RandomWord class (implemented later)
   */
}

class RandomWords extends StatefulWidget{
  /* RandomWords: stateful widget for RandomWordsState; mostly just create its
   * state class
   */
  @override

}