import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicinskatechnika/model/appstate.dart';
import 'package:medicinskatechnika/ui/screens/form.dart';
import 'package:medicinskatechnika/ui/screens/product.dart';
import 'package:medicinskatechnika/ui/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryListing extends StatefulWidget {
  String header;
  String title;

  CategoryListing({this.header, this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryListingState();
  }
}

class CategoryListingState extends State<CategoryListing> {
  var text = TextEditingController();
  bool _loading = false;

  List<Widget> _list() {
    List<Widget> _data = [];

    if (_newData.length != 0) {
      for (var data in _newData) {
        String v = NumberFormat.decimalPattern("inr")
            .format(int.parse(data['Price_vat']));

        _data.add(InkWell(
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Product(
                        header: widget.header,
                        title: data['Product'],
                        productId: data['Item_Id'],
                        desc: data['Desc'],
                        image: data['imageUrl'],
                        price: v,
                        price1: data['Price_vat'],
                        deliveryId: data['deliveryId'],
                        deliveryPrice: data['deliveryPrice_COD']
                        //fmf.output.withoutFractionDigits,
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
                              side:
                                  BorderSide(width: 1, color: Colors.black26)),
                          elevation: 0,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            child: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: data['imageUrl'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 60,
                                width: 60,
                                child: Image.asset("assets/empty.jpg"),
                              ),
                            ),
                          ),
                        ),
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

  List<Map<String, dynamic>> _newData = [];

  _onChanged(String value) {
    final appState = Provider.of<AppState>(context, listen: false);
    setState(() {
      _newData = appState.homemodal.products
          .where((row) => row['Product'].contains(value))
          .toList();
    });
  }

  getSearchCat({BuildContext context}) {
    final appState = Provider.of<AppState>(context, listen: false);
    _newData = appState.homemodal.products
        .where((row) => row['Product'].contains(text.text))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchCat(context: context);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _newData.clear();
    // _list().clear();
    setState(() {
      _loading = true;
    });
    print("skfknk");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
//    _logList();
//    _logSummery();
    //  _loadList();

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

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        print("yes");
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
          endDrawer: DrawerWidget(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.header.toUpperCase(),
              style: TextStyle(fontSize: 15),
            ),
          ),
          bottomNavigationBar: appState.homemodal.amount != null
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormCart(
                                // title: widget.title,
                                // productId: widget.productId,
                                // price: widget.price,
                                )));
                  },
                  child: Container(
                    height: 50,
                    color: Color(0xFF063257),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.shopping_basket,
                                color: Color(0xffa12036),
                                size: 35,
                              ),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              child: Text(
                                "Nakupni Kosik",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            ),
                          ],
                        ),
                        Container(
                          child: Text(
                            appState.homemodal.amount.toString() + "\tKč",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xffa12036),
                                fontWeight: FontWeight.bold),
                          ),
                          margin: EdgeInsets.only(right: 20),
                        )
                      ],
                    ),
                  ))
              : null,
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
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
              child: Container(
                  child: Column(
                children: <Widget>[
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
                                contentPadding: EdgeInsets.only(top: 10),
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
                  _list().length != null
                      ? Container(
                          child: _loading
                              ? CircularProgressIndicator()
                              : ListView.builder(
                                  itemCount: _list().length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _list()[index];
                                  }))
                      : Container()
                ],
              )),
            ),
          )),
    );
  }
}
