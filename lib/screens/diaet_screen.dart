import 'package:diaetapp/helpers/db_helper.dart';
import 'package:diaetapp/provider/diaet_entry.dart';
import 'package:diaetapp/screens/add_new_diaet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

//var db = new DBHelper();
//Future<List> _places = db.getAllRecords("user_places");

class DiaetListScreen extends StatefulWidget {
  static const routName = '/diaet-list';
  @override
  _DiaetListScreenState createState() => _DiaetListScreenState();
}

class _DiaetListScreenState extends State<DiaetListScreen> {
  var _isDeleted = false;

  @override
  Widget build(BuildContext context) {
    //final scaffold = Scaffold.of(context);
    return Scaffold(
        appBar: //Platform.isIOS
            //? CupertinoNavigationBar(
            //  middle: Text('Berg-Tagebuch'),
            //  icon: Icon(Icons.add),
            //  onPressed: () {
            //  Navigator.of(context).pushNamed(AddPlacesScreen.routName);
            // }),
            //)
            // : AppBar(
            AppBar(
          title: Text('Diät-Tagebuch'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.green[200],
                  Colors.brown[300],
                ])),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //zum neuen Screen add_new_diaet navigieren
                Navigator.of(context).pushNamed(AddDiaetScreen.routName);
              },
            ),
          ],
        ),
        body: FutureBuilder<List>(
          future: Future.wait([
            Provider.of<GreatDiaet>(context, listen: false).fetchAndSetPlaces(),
          ]),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatDiaet>(
                  child: Center(
                    child:
                        const Text('Starte jetzt mit deinem Diät Tagebuch !'),
                  ),
                  builder: (ctx, greatDiaet, ch) => greatDiaet.items.length <= 0
                      ? ch
                      : //ListView.separator -----> mit Linien was ist besser ?
                      ListView.builder(
                          itemCount: greatDiaet.items.length,
                          itemBuilder: (ctx, index) => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListTile(
                              title: Text(greatDiaet.items[index].title),
                              subtitle: Text(greatDiaet.items[index].kcal),
                              //   On Tap öffnet dann die Details Seite
                              // onTap: () => Navigator.of(context).pushNamed(
                              //    // PlaceDetailScreen.routName,
                              //     arguments: greatDiaet.items[index].id),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    //Button um in den bearbeitungsmodus zu wechseln
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () =>
                                          //   //  Navigator.of(context).pushNamed(
                                          //     //  EditPlacesScreen.routName,
                                          //       arguments:
                                          //           greatDiaet.items[index].id,
                                          //     ),
                                          // color: Colors.cyan),
                                          IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          try {
                                            print(_isDeleted);
                                            return showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (param) {
                                                  return AlertDialog(
                                                    actions: [
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("Abbruch"),
                                                        color:
                                                            Colors.green[100],
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          DBHelper.delete(
                                                              greatDiaet
                                                                  .items[index]
                                                                  .id);
                                                          //set state damit löschen aktualisiert wird
                                                          setState(() {});

                                                          Scaffold.of(ctx)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Der Diäteintrag wurde entfernt")));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Löschen"),
                                                        color: Colors.red[200],
                                                      ),
                                                    ],
                                                    title: Text(
                                                        "Diät wirklich löschen ?"),
                                                  );
                                                });
                                          } catch (error) {
                                            //Hinweis geben das löschen fehlgeschlagen ist über snackbar
                                            //  scaffold.showSnackBar(SnackBar(
                                            //   content: Text(
                                            // 'Löschen Fehlgeschlagen !!',
                                            // textAlign: TextAlign.center,
                                            // )));
                                          }
                                        },
                                        color: Theme.of(context).errorColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // separatorBuilder: (context, index) => Divider(
                          //   color: Colors.black,
                          // ),
                        ),
                ),
        ));
  }
}
