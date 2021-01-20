import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medicinskatechnika/model/appstate.dart';
import 'package:medicinskatechnika/ui/screens/product.dart';
import 'package:medicinskatechnika/ui/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool _loading = false;
  ScrollController _scrollController;
  final List<String> imgList = [
    'https://www.medicinskatechnika.cz/modules/wpimageslider/views/img/f43a317179804e30e072769d8bedf687158fac47_banner_4.jpg',
    'https://www.medicinskatechnika.cz/modules/wpimageslider/views/img/9e36e6074080e5694f5179abee046f576b081bce_TEPLOMER.jpg',
  ];

  var text = TextEditingController();
  final client = HttpClient();
  var _itemNumber = 10;

  List<Map<String, dynamic>> _newData = [];

  List<Widget> _list() {
    List<Widget> _data = [];

    if (_newData.length != 0) {
      for (var data in _newData) {
        String v = NumberFormat.decimalPattern("inr")
            .format(int.parse(data['Price_vat']));

        _data.add(InkWell(
          onTap: () async {
            //  print(price);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Product(
                        header: data['Product'],
                        title: data['Product'],
                        productId: data['Item_Id'],
                        desc: data['Desc'],
                        image: data['imageUrl'],
                        price1: data['Price_vat'],
                        price: v,
                        deliveryId: data['deliveryId'],
                        deliveryPrice: data['deliveryPrice_COD']
                        //  price: fmf.output.withoutFractionDigits,
                        )));
          },
          child: Container(
            child: Card(
              elevation: 0.5,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                side: BorderSide(
                                    width: 1, color: Colors.black26)),
                            elevation: 0,
                            child: Image(
                                width: 60,
                                height: 60,
                                image: CachedNetworkImageProvider(
                                    data['imageUrl']))),
                        Flexible(
                            child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  data['Product'],
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffCC0D1A),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  v + ",-Kč",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
    }

    return _data;
  }

  _onChanged(String value) {
    final appState = Provider.of<AppState>(context, listen: false);
    setState(() {
      _newData = appState.homemodal.allProducts
          .where((row) => row['Product'].contains(value))
          .toList();

      _itemNumber = _newData.length;
      print(_itemNumber);
      print(_newData.length);
    });
  }

  getSearchCat({BuildContext context}) {
    final appState = Provider.of<AppState>(context, listen: false);
    _newData = appState.homemodal.allProducts
        .where((row) => row['Product'].contains(text.text))
        .toList();
    _itemNumber = _newData.length;
    print(_itemNumber);
    print(_newData.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    print("scroll");

    getSearchCat(context: context);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    _newData.clear();
    _list().clear();

    setState(() {
      _loading = true;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    getSearchCat(context: context);

    setState(() {
      _loading = false;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  _scrollListener() {
    print("scrollController");
    if (text.text.isNotEmpty) {
      _scrollController.dispose();
    }
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("scroll2");
      setState(() {
        _itemNumber += 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        endDrawer: DrawerWidget(),
        appBar: AppBar(
          title: Text(
            "Medicinskatechnika.cz",
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
            onWillPop: () async {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Exit"),
                      content: Text("Are you sure you want to exit?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("YES"),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                        ),
                        FlatButton(
                          child: Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              //  header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Color(0xffe5e8ed),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              height: 30,
                              //   color: Colors.white,
                              margin: EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: text,
                                onChanged: _onChanged,
                                decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 0.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(7.0),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  //            contentPadding: EdgeInsets.only(top: 10),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "Vyhledávání",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Zrušit",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    _list().length != 0
                        ? Container(
                            height: MediaQuery.of(context).size.height / 1.21,
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: _itemNumber,
                                // cacheExtent: 1500,
                                shrinkWrap: true,
                                //  physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return _list()[index];
                                }),
                          )
                        : Container()
                  ],
                ),
              ),
            )));
  }
}
