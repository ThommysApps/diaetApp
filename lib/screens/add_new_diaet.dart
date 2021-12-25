import 'package:diaetapp/provider/diaet_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddDiaetScreen extends StatefulWidget {
  static const routName = '/add-diaet';

  @override
  _AddDiaetScreenState createState() => _AddDiaetScreenState();
}

class _AddDiaetScreenState extends State<AddDiaetScreen> {
  //Controller um das Titel zu "Kontrollieren"
  final _titleController = TextEditingController();
  final _pickedCarbhydrate = TextEditingController();
  final _pickedkcal = TextEditingController();
  final _pickedStartWeight = TextEditingController();
  final _pickedNewWeight = TextEditingController();
  final _pickedMaxKcal = TextEditingController();
  final _pickedDifKcal = TextEditingController();

  final _formKey = GlobalKey<FormState>();

// set up the AlertDialog
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Hoppala...'),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('OK'))
              ],
            ));
  }

  void _savePlace() {
    if (_titleController.text.isEmpty) {
      var errorMessage = 'Bitte gib einen Titel ein';
      return _showErrorDialog(errorMessage);
    }

    //add place ausführen über provider
    Provider.of<GreatDiaet>(context, listen: false).addDiaet(
        _titleController.text,
        _pickedCarbhydrate.text,
        _pickedkcal.text,
        _pickedStartWeight.text,
        _pickedNewWeight.text,
        _pickedMaxKcal.text,
        _pickedDifKcal.text);
    Navigator.of(context).pop();
  }

  void saveTestValidation() {}

  @override
  Widget build(BuildContext context) {
    //bei ganzer Seite ein Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text('Füge deinen Diättag hinzu'),
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
      ),
      //Body mit Column da -> Spalte da wir sachen übereinander sind also von oben nach unten
      body: Column(
        key: _formKey,
        //Text und Button werden getrennt oben und unten
        //mainAxisAlignment: MainAxisAlignment.spaceBetween <---- mit Expanded wird das nicht mehr benötigt
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Textfelder untereinander mit einem Expanded einfügen
          //Column warp mit widget dann Padding dann Padding wrappen mit SingleCHildScrollView in die Column kommen dann die Textfelder
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Kohlenhydrate'),
                    controller: _pickedCarbhydrate,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field is required';
                      }
                    },
                    // hier erweitern mit valdiation etc...
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Kcal'),
                    controller: _pickedkcal,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Sizedbox mit 10 Pixel für eine nkleinen Abstand
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Beschreibung',
                        hintText: "Kurze Beschreibung der Diät"),
                    controller: _pickedStartWeight,
                  ), //-------------------- Höhenmeter ----------------
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'neues gewicht',
                        counterText: "",
                        contentPadding: EdgeInsets.all(1)),
                    controller: _pickedNewWeight,
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),

                  ///---------------------Dauer der Wanderung ---------------------------
                  TextField(
                      decoration: InputDecoration(
                          labelText: 'Maximale Kcal pro Tag',
                          counterText: "",
                          contentPadding: EdgeInsets.all(1)),
                      controller: _pickedMaxKcal,
                      maxLength: 5,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]), //-------------------Länge der Wanderung--------------
                  TextField(
                      decoration: InputDecoration(
                          labelText: 'Kcal Differenz',
                          counterText: "",
                          contentPadding: EdgeInsets.all(1)),
                      controller: _pickedDifKcal,
                      maxLength: 5,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Diät Hinzufügen'),
            // onPressed: _savePlace,
            onPressed: _savePlace,
            elevation: 0,
            //Der button ist ganz unten an der Kante
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
