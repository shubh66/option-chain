import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:optionchain/Details.dart';
import 'package:optionchain/OptionBloc.dart';
import 'package:optionchain/equitiesListPage.dart';
import 'package:optionchain/sharedPre.dart';

Future<void> main() async {
  Stetho.initialize();
  SharedPrefManager.getSharedPref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Option Chain',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Option chain'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OptionBloc _optionBloc = OptionBloc();

  void navigationWith(String data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OptionChainDetails(mainTitle: "$data"),
      ),
    );
  }

  @override
  void initState() {
    _optionBloc.getCookies();
    super.initState();
  }

  ElevatedButton raisedButton(String title) {
    return ElevatedButton(
      onPressed: () {
        navigationWith("$title");
      },
      child: new Text("$title"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            raisedButton("NIFTY"),
            SizedBox(
              height: 20,
            ),
            raisedButton("BANKNIFTY"),
            SizedBox(
              height: 20,
            ),
            // raisedButton("FINNIFTY"),
            //
            ElevatedButton(
              child: Text("Sell all equities"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EquitiesList()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.ac_unit),
        onPressed: () => _optionBloc.setEquitiesList(),
      ),
    );
  }
}
