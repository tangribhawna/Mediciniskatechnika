import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:medicinskatechnika/model/appstate.dart';
import 'package:medicinskatechnika/ui/widgets/drawer.dart';
import 'package:provider/provider.dart';

class FormCart extends StatefulWidget {
  // FormCart({this.title, this.price, this.productId});

  FormCart({this.deliveryPrice, this.deliveryId});

  // String price;
  // String title11;
  // String productId;
  String deliveryId;
  String deliveryPrice;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormCartState();
  }
}

class FormCartState extends State<FormCart> {
  var name = TextEditingController();
  var phone = TextEditingController();
  var emailA = TextEditingController();
  var address = TextEditingController();
  var quantity = TextEditingController();
  int value = 1;
  // bool _validate = false;

  bool _loading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  main(BuildContext context, {AppState appState}) async {
    // String username = "tangribhawna@outlook.com";
    // //String password = "helpsuithkbjhynz";
    //
    // String password = "Bhawna@123";

    final smtpServer = SmtpServer("mail.medicinskatechnika.cz",
        username: "appka@medicinskatechnika.cz",
        password: "Ts710731Ts",
        port: 25,
        ignoreBadCertificate: true,
        ssl: false,
        allowInsecure: true);
    // Creating the Gmail server

    // Create our email message.
    final message = Message();

    message.from =
        Address("appka@medicinskatechnika.cz"); //info@medicinskatechnika.cz
    message.recipients.add('info@medicinskatechnika.cz');
    message.subject = "'Objednávka z mobilni aplikace ${DateTime.now()}'";
    // message.attachments = appState.homemodal.cartProduct.;
    message.text = "\nName: " +
        name.text +
        "\n" +
        "Email: " +
        emailA.text +
        "\n" +
        "telephone: " +
        phone.text +
        "\n" +
        "Address: " +
        address.text +
        "\nproducts :" +
        appState.homemodal.cartProducts.toString() +
        "\nfinal Price :" +
        NumberFormat.decimalPattern("inr").format(
            (appState.homemodal.amount + int.parse(widget.deliveryPrice)));

    if (validateAndSave()) {
      setState(() {
        _loading = true;
        height = 30;
        height1 = 55;
      });
      print(message.text);
      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString()); //p
        final snackBar = SnackBar(
          content: Text('Sent Successfully'),
        );

        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        _scaffoldKey.currentState.showSnackBar(snackBar);

        setState(() {
          _loading = false;
        });
        // rint if the email is sent
      } on MailerException catch (e, s) {
        print('Message not sent. \n' + e.toString());
        setState(() {
          _loading = false;
        });

        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }

        //print if the email is not sent
        // e.toString() will show why the email is not sending
      }
    } else {
      setState(() {
        height = 50;
        height1 = 55;
      });
    }
  }

  int cartTotal;

  void takeNumber(String text, String price, AppState appState) {
    try {
      cartTotal = 0;
      print(text);
      print(price);

      for (var i = 0; i < appState.homemodal.cartProducts.length; i++) {
        if (appState.homemodal.cartProducts[i]['Product Price'] == price) {
          appState.homemodal.cartProducts[i]['quantity'] = text;
          appState.notifyChange();
        }

        try {
          cartTotal +=
              (int.parse(appState.homemodal.cartProducts[i]['Product Price']) *
                  int.parse(appState.homemodal.cartProducts[i]['quantity']));
          appState.homemodal.addAmount(amount: cartTotal);
        } catch (e) {
          print(e.toString());
        }
        print(cartTotal);
      }

      print(appState.homemodal.cartProducts);
    } catch (e, s) {
      print(s.toString());
    }
  }

  List<Widget> _cartProduct() {
    List<Widget> _cart = [];

    cartTotal = 0;

    final appState = Provider.of<AppState>(context, listen: false);

    for (var data in appState.homemodal.cartProducts) {
      try {
        cartTotal +=
            (int.parse(data['Product Price']) * int.parse(data['quantity']));
        appState.homemodal.addAmount(amount: cartTotal);
      } catch (e) {
        print(e.toString());
      }
      _cart.add(
        InkWell(
          onTap: () {
            print(data['Product Id']);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: Text(
                      data['Product Name'],
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 35,
                      child: TextFormField(
                          //    controller: quantity,
                          keyboardType: TextInputType.number,
                          initialValue: data['quantity'] ?? 0,
                          onChanged: (value) {
                            print(value);
                            if (value.isEmpty && value == null) {
                              takeNumber("1", data['Product Price'], appState);
                            } else {
                              takeNumber(
                                  value, data['Product Price'], appState);
                            }
                            //  takeNumber(value, data['Product Price'], appState);
                          },
                          decoration: InputDecoration(
                            //   hintText: "1",
                            //   errorText: _validate ? 'Empty' : null,
                            contentPadding:
                                EdgeInsets.only(bottom: 5, left: 10),
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(7.0),
                              ),
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Ks",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return _cart;
  }

  double height = 30;
  double height1 = 35;
  @override
  Widget build(BuildContext context) {
    //   quantity.text = value.toString();
    final appState = Provider.of<AppState>(context, listen: false);
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Nákupní košík",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
      endDrawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _cartProduct().length != 0
                    ? Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _cartProduct().length,
                            itemBuilder: (BuildContext context, int index) {
                              return _cartProduct()[index];
                            }),
                      )
                    : Container(),
                Container(
                  color: Color(0xffe4e8eb),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 20),
                        child: Text(
                          "Osobní údaje",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        height: height,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: name,
//                          onChanged: _onChanged,
                                validator: (val) => val.isEmpty
                                    ? 'fullName can\'t be empty.'
                                    : null,
                                style: TextStyle(fontSize: 12),
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
                                  contentPadding:
                                      EdgeInsets.only(top: 10, left: 10),
                                  hintText: "Jméno a příjmení",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        height: height,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: emailA,
                                validator: (val) {
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                    return "Enter valid email address";
                                  }

                                  return null;
                                },
//                          onChanged: _onChanged,
                                style: TextStyle(fontSize: 12),
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
                                  contentPadding:
                                      EdgeInsets.only(top: 10, left: 10),
                                  hintText: "E-mailová adresa",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        height: height,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: phone,
                                validator: (val) => val.isEmpty
                                    ? 'Telefon can\'t be empty.'
                                    : null,
//                          onChanged: _onChanged,
                                style: TextStyle(fontSize: 12),
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
                                  contentPadding:
                                      EdgeInsets.only(top: 10, left: 10),
                                  hintText: "Telefon",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        height: height,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                style: TextStyle(fontSize: 12),
                                controller: address,
//                          onChanged: _onChanged,
                                validator: (val) => val.isEmpty
                                    ? 'Address can\'t be empty.'
                                    : null,
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
                                    contentPadding:
                                        EdgeInsets.only(top: 10, left: 10),
                                    hintText: "Dodací adresa",
                                    helperStyle: TextStyle(fontSize: 12)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text(
                              widget.deliveryId,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            child: Text(
                              widget.deliveryPrice + ",-Kč",
                              style: TextStyle(fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      main(context, appState: appState);
                      // if (quantity.text.isNotEmpty) {
                      //   height1 = 35;
                      //   _validate = false;
                      //   main(context, appState: appState);
                      // } else {
                      //   height1 = 55;
                      //   _validate = true;
                      // }
                    });
                  },
                  child: _loading
                      ? CircularProgressIndicator()
                      : Container(
                          margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xffCC0D1A),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Objednat",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  NumberFormat.decimalPattern("inr").format(
                                          (appState.homemodal.amount +
                                              int.parse(
                                                  widget.deliveryPrice))) +
                                      ",-Kč",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
