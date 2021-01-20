import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicinskatechnika/model/appstate.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  final client = HttpClient();

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  _getCat() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'https://www.medicinskatechnika.cz/rss/MobilAPPMedicinskatechnika.xml');
    final request = await client.getUrl(url);
    final response = await request.close();

    final stream = response.transform(utf8.decoder);
    final input = await stream.join();
    final document = XmlDocument.parse(input);
    final appState = Provider.of<AppState>(context, listen: false);

    Navigator.pushReplacementNamed(context, '/home');

    for (final element in document.rootElement.children) {
      if (element is XmlElement) {
      appState.homemodal.categories.add(element.getElement("CATEGORYTEXT").text);
        appState.homemodal.allProducts.add({
          "Product": element.getElement("PRODUCT").text,
          "Desc": element.getElement("DESCRIPTION").text,
          "Url": element.getElement("URL").text,
          "Price": element.getElement("PRICE").text,
          "Price_vat": element.getElement("PRICE_VAT").text,
          "Vat": element.getElement("VAT").text,
          "Item_Id": element.getElement("ITEM_ID").text,
          "category": element.getElement("CATEGORYTEXT").text,
          "imageUrl": element.getElement("IMGURL").text,
          "deliveryId":
              element.getElement("DELIVERY").getElement("DELIVERY_ID").text,
          "deliveryPrice":
              element.getElement("DELIVERY").getElement("DELIVERY_PRICE").text,
          "deliveryPrice_COD": element
              .getElement("DELIVERY")
              .getElement("DELIVERY_PRICE_COD")
              .text
        });

        // if (appState.homemodal.allProducts.length != 0) {
        //   for (var data in appState.homemodal.allProducts) {
        //     print(data['category']);
        //     print()
        //     if (data['category'] == element.getElement("CATEGORYTEXT").text) {
        //
        //     } else {
        //       appState.homemodal.categories.add({
        //         "category": data['category'],
        //       });
        //     }
        //   }
        // }
      }
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    _getCat();
    //  Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      print(result);
      if (result == ConnectivityResult.none) {
        showAlertDialog(context);
      }
      print("ConnectionResult");
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("No Internet Connection"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: new Image.asset(
              'assets/splash.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // fit: BoxFit.cover,
            ),
          ),
          _isLoading
              ? Container(
                  //   color: Colors.purpleAccent,
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
