import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicinskatechnika/ui/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContactScreenState();
  }
}

class ContactScreenState extends State<ContactScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  @override
  Widget build(BuildContext context) {
    markers.addAll([
      Marker(
          markerId: MarkerId('value'),
          position: LatLng(50.0220275, 14.4877750)),
    ]);
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Kontakt",
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          centerTitle: true,
        ),
        endDrawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Provozovatel:",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "Tomáš Slavíček - Medicinskatechnika.cz",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "Kamenická 811/35; 170 00 Praha 7",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "IČO: 71922997",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    " DIČ: CZ7107310045",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.black45,
                ),
                InkWell(
                  onTap: () {
                    _makePhoneCall('tel: + 420 603 440 557');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffce0d1e),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Zatelefonovat  (+ 420 603 440 557 )",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    launch(_emailLaunchUri.toString());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffce0d1e),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Poslat e-mail",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchInBrowser(
                        "https://www.medicinskatechnika.cz/content/3-terms-and-conditions-of-use");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffce0d1e),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Obchodní podmínky",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffce0d1e),
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Osobní odběr Jana Růžičky 1234/4; 148 00 Praha 4",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Container(
                    height: 250,
                    padding: EdgeInsets.all(10),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer())),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(50.0220275, 14.4877750), zoom: 10),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      mapToolbarEnabled: true,
                      myLocationEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      onCameraMove: ((_position) {
                        print(_position);
                        print("fkjg");

                        setState(() {});
                        //   _updatePosition(position: _position);
                      }),
                      markers: Set<Marker>.of(markers),
                    )),
              ],
            ),
          ),
        ));
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  final Uri _emailLaunchUri =
      Uri(scheme: 'mailto', path: 'info@medicinskatechnika.cz');
}
