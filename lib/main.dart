import 'package:diaetapp/provider/diaet_entry.dart';
import 'package:diaetapp/screens/add_new_diaet.dart';
import 'package:diaetapp/screens/diaet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Path Provider wird für dür den Pfad benötift "Dependencies installieren
//Ebenso Path wird auch benötigt als Plugin
// test

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ChangeNotiferProvider.value statt MaterialApp da wird abhängig davon was in den Places so abgeht die App aktualisieren
    return ChangeNotifierProvider.value(
      value: GreatDiaet(),
      child: MaterialApp(
        title: 'Diät-Tagebuch',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: DiaetListScreen(),
        routes: {
          AddDiaetScreen.routName: (ctx) => AddDiaetScreen(),
        },
      ),
    );
  }
}
