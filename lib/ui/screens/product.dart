import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicinskatechnika/model/appstate.dart';
import 'package:medicinskatechnika/ui/screens/form.dart';
import 'package:medicinskatechnika/ui/widgets/drawer.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  String header;
  String title;
  String image;
  String desc;
  String price;
  String productId;
  String url;
  String price1;
  String deliveryId;
  String deliveryPrice;

  Product(
      {this.price,
      this.price1,
      this.desc,
      this.image,
      this.header,
      this.title,
      this.productId,
      this.deliveryId,
      this.deliveryPrice,
      this.url});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductState();
  }
}

class ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.header),
        ),
        endDrawer: DrawerWidget(),
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
                              deliveryId: widget.deliveryId,
                              deliveryPrice: widget.deliveryPrice)));
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
                              "Nákupní košík",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            margin: EdgeInsets.only(left: 20),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          NumberFormat.decimalPattern("inr")
                                  .format(appState.homemodal.amount) +
                              ",-Kč",
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 20),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  onTap: () {
                    if (appState.homemodal.amount != null) {
                      var price1 = int.parse(widget.price1);
                      var price2 = appState.homemodal.amount;
                      var price_vat = price1 + price2;

                      appState.homemodal.addAmount(amount: price_vat);
                      appState.notifyChange();
                    } else {
                      appState.homemodal
                          .addAmount(amount: int.parse(widget.price1));

                      appState.notifyChange();
                    }
                    if (appState.homemodal.cartProducts.length != 0) {
                      print(appState.homemodal.cartProducts);
                      for (var data in appState.homemodal.cartProducts) {
                        print(data);
                        if (data['Product Id'] == widget.productId) {
                          print("666666");
                        } else {
                          appState.homemodal.cartProducts.add({
                            "Product Name": widget.title,
                            "Product Id": widget.productId,
                            "Product Price": widget.price1,
                            "quantity": "1"
                          });
                        }
                      }
                    } else {
                      appState.homemodal.cartProducts.add({
                        "Product Name": widget.title,
                        "Product Id": widget.productId,
                        "Product Price": widget.price1,
                        "quantity": "1"
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            widget.price + ",-Kč",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: Color(0xffCC0D1A),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "do košíku".toUpperCase(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      side: BorderSide(width: 1, color: Colors.black26)),
                  elevation: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      height: 250,
                      width: 250,
                      imageUrl: widget.image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 250,
                        width: 250,
                        child: Image.asset("assets/empty.jpg"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.desc != null
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          widget.desc,
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}
