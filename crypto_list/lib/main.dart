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
  List _cryptoList; //store cryptolist
  //favorites: similar to wordpair tutorial
  final _saved = Set<Map>();
  //make bold text style
  final _boldStyle =
      new TextStyle(fontWeight: FontWeight.bold);
  bool _loading = false; //used later, control state
  //make list to show different colors by crypto
  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.lime,
    Colors.teal,
    Colors.cyan
  ];
  /*this function: will be executed sometime in the
   * future (in this case doesn't return data
   */
  Future<void> getCryptoPrices() async {
    /*async: indicate wait, suspect current function,
     * data not ready yet, let main thread do other stuff
     * in the meantime
     */
    print('getting crypto prices'); //print
    String _apiURL =
      //URL to get the price data (API)
      "http://api.coinmarketcap.com/v1/ticker/";

    //before calling API (before loading begins), set _loading to true
    setState(() {
      this._loading = true;
    });
    //waits for decision
    http.Response response = await http.get(_apiURL);
    setState(() {
      this._cryptoList =
          //decode the json (api) data into a readable
          //format
          jsonDecode(response.body);
      //we have now loaded the json and list, set loading false
      this._loading = false;
      print(_cryptoList); //prints the list
      });
      return;
  }

  //take in an object and returns price w/ 2 decimal places
  String cryptoPrice(Map crypto) {
    int decimals = 2;
    //pow: dart math: return 10^2
    /* basic idea: multiply number by that power of 10, round that number,
     * than divide by that same power of ten
     */
    int fac = pow(10, decimals);
    /*get price: parse "crypto" (passed in crypto name/array for that crypto)
     * api really just nested array, parse each cryptos array for price, passed
     * in one at a time
     */
    double d = double.parse(crypto['price_usd']);
    return "\$" + (d = (d * fac).round() / fac).toString();
  }

  //take in an object, color, return circle avatar, first letter and color
  /* CirlceAvatar: material library: used for profile image or initials,
   * always pair user's initials same color for consistency
   * use: backgroundImage or backgroundColor and child: Text
   */
  CircleAvatar _getLeadingWidget(String name, MaterialColor color){
    return new CircleAvatar(
      backgroundColor: color,
      //get first character of name field from API
      child: new Text(name[0]),
    );
  }

  //implement getmainbody function, loading bar if _loading is true
  _getMainBody() {
    if (_loading) {
      //loading API is true, create new center container for progress bar
      return new Center(
        //use built in circular loading bar; child
        child: new CircularProgressIndicator(),
      );
    } else {
      //loading is done, return the rest of the app as body
      /*also, add pull to refresh with RefreshIndicator, uses Material class
       * "swipe to refresh." Uses the child Scrollable, in this case the list.
       * swipe to begin refresh, have to swipe all the way. Possible becasue
       * widget stateful
       */
      return new RefreshIndicator(
        child: _buildCryptoList(),
        /*below: set action to take place on refresh, in this case call get
         *crypto prices to update price
         */
        onRefresh: getCryptoPrices,
      );
    }
  }

  /* Next, override initState method to change how state of app initializes
   * have to override and then call super.initState(); we use to enable a call
   * to getCryptoPrice on app start and set the app state
   */
  @override
  void initState() {
    //override creation of state call function
    super.initState();
    //call function to set state
    getCryptoPrices();
  }

  //next: set up material design of appp
  //build method
  @override
  Widget build(BuildContext context){
    //implement material design visual layout API class
    return Scaffold(
      appBar:// PreferredSize(

        //preferredSize: Size.fromHeight(200.0),
         // preferredSize: Size(100, 150),
        AppBar(
          //title: Text('CryptoList'),
          title: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/moneyTreeAndroid.png',
                  //fit: BoxFit.scaleDown,
                  height: 75,
                ),
                Container(
                  //padding: const EdgeInsets.all(8.0),
                  child: Text('CryptoList'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            //use icon to view favorites
            new IconButton(
                icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
      //),
      //body of scaffold: list
      body: _getMainBody(),
    );
  }

  //use later: favorites
  void _pushSaved() {}

  //widget that builds the list
  Widget _buildCryptoList() {
    //build items in a list view, similar to word pairs
    return ListView.builder(
      //set item count: ensure index is in range
      itemCount: _cryptoList.length,
      //padding:inset margin inside list tile for content
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        //builder: return row for each index i=0,1,2...
        //if odd row: return divider (like word pairs)
        final index = i;
        print(index);
        //iterate through colors, get next color
        final MaterialColor color = _colors[index % _colors.length];
        //call build row with list item and color
        return _buildRow(_cryptoList[index], color);
      }
    );
  }

  //function to build row
  //pass in Map: key value pairing: inner array for chosen crypto
  //keys i.e. id, name... values i.e. bitcoin, $3000
  Widget _buildRow(Map crypto, MaterialColor color){
    //if _saved contains our crypto, return true
    final bool favorited = _saved.contains(crypto);
    //function to handle: heart icon tapped
    void _fav(){
      setState((){
        if(favorited){
          //if previously favorited, remove from list
          _saved.remove(crypto);
        } else {
          //add
          _saved.add(crypto);
        }
      }
      );
    }
    //return a row with desired properties
    return ListTile(
      //leading: widget display before title
      //get leading widget: get first letter text, name
      leading: _getLeadingWidget(crypto['name'], color),
      //title of crypto
      title: Text(crypto['name']),
      //show actual price, subtitle
      subtitle: Text(
        cryptoPrice(crypto),
        //use bold text style
        style: _boldStyle,
      ),
      //add iconbutton to favorite
      trailing: new IconButton(
        //if button favorited, show correct logo
        icon: Icon(favorited ? Icons.favorite : Icons.favorite_border),
        color: favorited? Colors.red : null,
        onPressed: _fav,

      ),
    );
  }
}



