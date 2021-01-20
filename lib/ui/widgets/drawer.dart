import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicinskatechnika/model/appstate.dart';
import 'package:medicinskatechnika/ui/screens/categoriylisting.dart';
import 'package:medicinskatechnika/ui/screens/contact.dart';
import 'package:medicinskatechnika/ui/widgets/customWidget.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerWidgetState();
  }
}

class DrawerWidgetState extends State<DrawerWidget> {
  List<Widget> _getCategories() {
    List<Widget> cat = [];

    final appState = Provider.of<AppState>(context, listen: false);

    if (appState.homemodal.categories.length != 0) {
      var result = appState.homemodal.categories.toSet().toList();
      for (var category in result) {
        cat.add(CustomWidget.drawerWidget(
            context: context,
            text: category,
            onPressed: () {
              appState.homemodal.products.clear();
              if (appState.homemodal.allProducts.length != 0) {
                for (var data in appState.homemodal.allProducts) {
                  print(data['category']);
                  print(category);
                  if (data['category'] == category) {
                    appState.homemodal.products.add(data);
                    print("adjkdhj3");
                    print(data);
                  }
                }
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryListing(
                    header: category,
                    title: category,
                  ),
                ),
              );
            }));
      }
      cat.add(CustomWidget.drawerWidgetWithIcon(
          context: context,
          text: "Kontakt",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactScreen()));
          }));
    }
    return cat;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    print(appState.homemodal.categories.length);

    print("skdjksd");
    // TODO: implement build
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
//          margin: EdgeInsets.only(
//            top: 10,
//          ),
          color: Color(0xffce0d1e),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Color(0xFF105692),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 40,
                    ),
                    Container(
                      child: Text(
                        "Nabidka",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 30,
                        height: 50,
                        child: Image.asset("assets/arrowup.png"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                child: _getCategories().length != 0
                    ? ListView.builder(
                        itemCount: _getCategories().length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return _getCategories()[index];
                        })
                    : Container(
                        child: Text("No categories"),
                      ),
              )
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "AED DEFIBRILÁTORY",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "AED defibrilátory") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CategoryListing(
              //             header: "AED defibrilátory",
              //             title: "AED defibrilÃ¡tory",
              //           ),
              //         ),
              //       );
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Antidekubitní systém",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Antidekubitní systém") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CategoryListing(
              //             header: "Antidekubitní systém",
              //             title: "AntidekubitnÃ­ systÃ©m",
              //           ),
              //         ),
              //       );
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Defibrilátory",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Defibrilátory") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CategoryListing(
              //             header: "Defibrilátory",
              //             title: "DefibrilÃ¡tory",
              //           ),
              //         ),
              //       );
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Dermatoskop",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Dermatoskop") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => CategoryListing(
              //               header: "Dermatoskop",
              //               title: "Dermatoskop",
              //             ),
              //           ));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Dewarovy nádoby",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Dewarovy nádoby") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => CategoryListing(
              //               header: "Dewarovy nádoby",
              //               title: "Dewarovy nÃ¡doby",
              //             ),
              //           ));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Distanční elektroléčba",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "DistanÄnÃ­ elektrolÃ©Äba") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => CategoryListing(
              //               header: "Distanční elektroléčba",
              //               title: "DistanÄnÃ­ elektrolÃ©Äba",
              //             ),
              //           ));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "EKG",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "EKG") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "EKG",
              //                     title: "EKG",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "EKG holter",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "EKG holter") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => CategoryListing(
              //               header: "EKG holter",
              //               title: "EKG holter",
              //             ),
              //           ));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Elektrochirurgie - Elektrokoagulátory",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           print(data['category']);
              //           if (data['category'] ==
              //               "Elektrochirurgie - Elektrokoagulátory") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Elektrokoagulátory",
              //                     title:
              //                         "Elektrochirurgie - ElektrokoagulÃ¡tory",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Elektrochirurgie - TURis & TCRis - SAL",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           print(data['category']);
              //           if (data['category'] ==
              //               "Elektrochirurgie - TURis & TCRis - SAL") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "TURis & TCRis - SAL",
              //                     title:
              //                         "Elektrochirurgie - TURis & TCRis - SAL",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Elektrochirurgie - Nástroje a pinzety",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Elektrochirurgie - Nástroje a pinzety") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Nástroje a pinzety",
              //                     title:
              //                         "Elektrochirurgie - NÃ¡stroje a pinzety",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Epilace",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Epilace") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Epilace",
              //                     title: "Epilace",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Chladivá a hřejivá bandáž",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] == "Chladivá a hřejivá bandáž") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Chladivá a hřejivá bandáž",
              //                     title: "ChladivÃ¡ a hÅejivÃ¡ bandÃ¡Å¾",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Inhalátory",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] == "Inhalátory") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Inhalátory",
              //                     title: "InhalÃ¡tory",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Inkontinence",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] == "Inkontinence") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Inkontinence",
              //                     title: "Inkontinence",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Karboxyterapie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] == "Karboxyterapie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Karboxyterapie",
              //                     title: "Karboxyterapie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Kryochirurgie -Kryosprej",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] == "Kryochirurgie - Kryosprej") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kryosprej",
              //                     title: "Kryochirurgie - Kryosprej",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Kryochirurgie -Kryosystém",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] == "Kryochirurgie - Kryosystém") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kryosystém",
              //                     title: "Kryochirurgie - KryosystÃ©m",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Kryochirurgie -Kryo pero Freezpen",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           debugPrint(data['category']);
              //           if (data['category'] ==
              //               "Kryochirurgie - Kryo pero Freezpen") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kryo pero Freezpen",
              //                     title: "Kryochirurgie - Kryo pero Freezpen",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Kryoterapie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Physiomed - Kryoterapie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kryoterapie",
              //                     title:
              //                         "Rehabilitace - Přístroje Physiomed - Kryoterapie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Lasery terapeutické - Ovládací jednotky",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Lasery terapeutické - Ovládací jednotky") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Ovládací jednotky",
              //                     title:
              //                         "Lasery terapeutické - Ovládací jednotky",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Lasery terapeutické - Sondy polovodičové",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Lasery terapeutické - Sondy polovodičové") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Sondy polovodičové",
              //                     title:
              //                         "Lasery terapeutické - Sondy polovodičové",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Lasery terapeutické - Laserové scannery",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Lasery terapeutické - Laserové scannery") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Laserové scannery",
              //                     title:
              //                         "Lasery terapeutické - Laserové scannery",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Lasery terapeutické - Výkonové lasery",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Lasery terapeutické - Výkonové lasery") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Výkonové lasery",
              //                     title:
              //                         "Lasery terapeutické - Výkonové lasery",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Léčba hemoroidů",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           print(data['category']);
              //           if (data['category'] == "Léčba hemoroidů") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Inhalátory",
              //                     title: "Léčba hemoroidů",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Lymfodrenáž",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           print(data['category']);
              //           if (data['category'] == "Lymfodrenáž") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Lymfodrenáž",
              //                     title: "Lymfodrenáž",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Magnetorezonaní terapie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Magnetoresonance") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Magnetorezonaní terapie",
              //                     title: "Magnetoresonance",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Magnetoterapie - Klinické přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Magnetoterapie - Klinické přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Klinické přístroje",
              //                     title: "Magnetoterapie - Klinické přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Magnetoterapie - Aplikátory klinické",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Magnetoterapie - Aplikátory klinické") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Aplikátory klinické",
              //                     title: "Magnetoterapie - Aplikátory klinické",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Magnetoterapie - Domácí přístroje - sady",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Magnetoterapie - Domácí přístroje - sady") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Domácí přístroje - sady",
              //                     title:
              //                         "Magnetoterapie - Domácí přístroje - sady",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Magnetoterapie - Aplikátory domácí",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Magnetoterapie - Aplikátory domácí") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Aplikátory domácí",
              //                     title: "Magnetoterapie - Aplikátory domácí",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Magnetoterapie - Astar",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Magnetoterapie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Astar",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Magnetoterapie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Aktivní pohyb",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Motorové dlahy - Aktivní pohyb") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Aktivní pohyb",
              //                     title: "Motorové dlahy - Aktivní pohyb",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Koleno",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Motorové dlahy - Koleno") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Koleno",
              //                     title: "Motorové dlahy - Koleno",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Kotník",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Motorové dlahy - Kotník") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kotník",
              //                     title: "Motorové dlahy - Kotník",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Kyčel",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Motorové dlahy - Kyčel") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kyčel",
              //                     title: "Motorové dlahy - Kyčel",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Loket",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Motorové dlahy - Loket") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Loket",
              //                     title: "Motorové dlahy - Loket",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Rameno",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Motorové dlahy - Rameno") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Rameno",
              //                     title: "Motorové dlahy - Rameno",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Motorové dlahy - Ruka, zápěstí a prsty",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Motorové dlahy - Ruka, zápěstí a prsty") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Ruka, zápěstí a prsty",
              //                     title:
              //                         "Motorové dlahy - Ruka, zápěstí a prsty",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Myostimulátory",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Myostimulátory") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Myostimulátory",
              //                     title: "Myostimulátory",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Oxygenerátory",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Oxygenerátory") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Oxygenerátory",
              //                     title: "Oxygenerátory",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Plynové injekce",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Plynové injekce") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Plynové injekce",
              //                     title: "Plynové injekce",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Pulsní oxymetry",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Pulsní oxymetry") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Pulsní oxymetry",
              //                     title: "Pulsní oxymetry",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rázová vlna",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Rázová vlna") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Rázová vlna",
              //                     title: "Rázová vlna",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace - Přístroje Astar - Stimulační přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Stimulační přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Stimulační přístroje",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Stimulační přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text:
              //         "Rehabilitace - Přístroje Astar - Ultrazvukové přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Ultrazvukové přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Ultrazvukové přístroje",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Ultrazvukové přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace - Přístroje Astar - Vakuové přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Vakuové přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Vakuové přístroje",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Vakuové přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace - Přístroje Astar - Magnetoterapie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Magnetoterapie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Magnetoterapie",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Magnetoterapie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text:
              //         "Rehabilitace - Přístroje Astar - Kombinované přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Kombinované přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kombinované přístroje",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Kombinované přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace - Přístroje Astar - Léčba světlem",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Léčba světlem") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Léčba světlem",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Léčba světlem",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace - Přístroje Astar - Laserové přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Astar - Laserové přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Laserové přístroje",
              //                     title:
              //                         "Rehabilitace - Přístroje Astar - Laserové přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text:
              //         "Rehabilitace -Přístroje Physiomed - Oscilační přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Physiomed - Oscilační přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Oscilační přístroje",
              //                     title:
              //                         "Rehabilitace - Přístroje Physiomed - Oscilační přístroje",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace -Přístroje Physiomed - Diatermie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Physiomed - Diatermie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Diatermie",
              //                     title:
              //                         "Rehabilitace - Přístroje Physiomed - Diatermie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace -Přístroje Physiomed - Kryoterapie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Přístroje Physiomed - Kryoterapie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Kryoterapie",
              //                     title:
              //                         "Rehabilitace - Přístroje Physiomed - Kryoterapie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace -Distanční elektroléčba",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Distanční elektroléčba") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Distanční elektroléčba",
              //                     title:
              //                         "Rehabilitace - Distanční elektroléčba",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace -Magnetoresonance",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Magnetoresonance") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Magnetoresonance",
              //                     title: "Rehabilitace - Magnetoresonance",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace -Příslušenství Physiomed",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Příslušenství Physiomed") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Příslušenství Physiomed",
              //                     title:
              //                         "Rehabilitace - Příslušenství Physiomed",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Rehabilitace -Příslušenství Astar",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] ==
              //               "Rehabilitace - Příslušenství Astar") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Příslušenství Astar",
              //                     title: "Rehabilitace - Příslušenství Astar",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Teploměr bezkontaktní",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Teploměr bezkontaktní") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Teploměr bezkontaktní",
              //                     title: "Teploměr bezkontaktní",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Termochirurgie",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Termochirurgie") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Termochirurgie",
              //                     title: "Termochirurgie",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Tlakový holter",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Tlakový holter") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Tlakový holter",
              //                     title: "Tlakový holter",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Trombóza",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Trombóza") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Trombóza",
              //                     title: "Trombóza",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Uhličité koupele",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Uhličité koupele") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Uhličité koupele",
              //                     title: "Uhličité koupele",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Výkonové lasery",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Výkonové lasery") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Výkonový laser",
              //                     title: "Výkonové lasery",
              //                   )));
              //     }),
              // CustomWidget.drawerWidget(
              //     context: context,
              //     text: "Veterinární přístroje",
              //     onPressed: () {
              //       appState.homemodal.products.clear();
              //       if (appState.homemodal.allProducts.length != 0) {
              //         for (var data in appState.homemodal.allProducts) {
              //           if (data['category'] == "Veterinární přístroje") {
              //             appState.homemodal.products.add(data);
              //             print("adjkdhj3");
              //           }
              //         }
              //       }
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CategoryListing(
              //                     header: "Veterinární přístroje",
              //                     title: "Veterinární přístroje",
              //                   )));
              //     }),
              // SizedBox(
              //   height: 30,
              // ),
              // CustomWidget.drawerWidgetWithIcon(
              //     context: context,
              //     text: "Kontakt",
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => ContactScreen()));
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
