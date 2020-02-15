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
    //final wordPair = WordPair.random();
    return MaterialApp(
      /*title: 'Welcome to Flutter',
      home: Scaffold(*/
      title: 'Startup Name Generator',
      home: RandomWords(),
        /* Scaffold: widget from material library
         * provides default app bar, title, and
         * body property
         * body: holds widget tree, home screen
         */
        /*appBar: AppBar(
          title: Text('Welcome to FLutter'),
        ),
        body: Center(
          /* Center: aligns widget subtree
           * to center of screen (children)
           */
          //child: Text(wordPair.asPascalCase),
          //PascalCase: UpperCamelCase
          child: RandomWords(),
        ),
      ),*/
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
  @override
  /* Need to now add build method:
   *   -generates word pairs: moving code from MyApp to here
   */
  final _suggestions = <WordPair>[];
  //suggestions: saving suggested word pairs generated in a infinite list
  // underscore before variable (_x) denotes privacy
  final _biggerFont = const TextStyle(fontSize: 18.0);
  //bigger font: variable, make font 18 point

  Widget build(BuildContext context) {
    /*final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase); */
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );

  }

  Widget _buildSuggestions(){
    /* build suggestions for infinite scrolling list
     * Listview widget: builder: factory constructor, lists
     *  -itemBuilder: factory builder/callback
     *    -pass in BuildContext, row iterator i
     *    -iterator: begins at 0, incremements each time function called
     *    -increments twice each word pairing: once for ListTile, once for
     *     divider; allows list grow infinitely w/ scroll
     */
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i){
        /*itemBuilder: callback: called once per suggested pairing,
         * place each suggestion (context) into ListTile row (i)
         * Odd rows: add divider, visually seperate
         * ListTile: single fixed-height row: contains text w/ leading/
         * trailing icon i.e check box
         */
        if (i.isOdd) return Divider();
          //isOdd returns true if odd
          //all odd iterators: divider put in (between entries)
          //1 pixel high divider
          final index = i ~/ 2;
          //~/: truncate divide; like floor (drop fractional digits, int cast)
          if(index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
            /* If you've reached end of word pairing (index>=
             * _suggestions.length), generate 10 more and add them
             * to suggestions list
             */
          }
          return _buildRow(_suggestions[index]);

      }
    );
  }
  Widget _buildRow(WordPair pair){
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        )
    );
  }
}

class RandomWords extends StatefulWidget{
  /* RandomWords: stateful widget for RandomWordsState; mostly just create its
   * state class
   */
  @override
  /* @override: marks instance member as overriding a superclass member with
   * same name. Mainly: use methods: superclass out of programmer's control;
   * i.e. in different package
   * optional
   */
  RandomWordsState createState() => RandomWordsState();
}

/*
 * Left off: step 4: Creating infinite scrolling listView, write app
 */