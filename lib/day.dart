import 'package:flutter/material.dart';

class DayPage extends StatefulWidget {
  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  DateTime selectedDate = DateTime.now();
  List<String> jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Date sélectionnée : ${selectedDate.toLocal()}'.split(' ')[1],
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Sélectionnez une date'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Le jour de la date sélectionnée est : ${jours[(calculerJour(selectedDate.day, selectedDate.month, selectedDate.year) + 5) % 7]}',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  int calculerJour(int jour, int mois, int annee) {
    List<int> f = [0,3,3,6,1,4,6,2,5,0,3,5];
    int A = annee - 1900;
    int J = jour;
    int M = mois;
    return (J + A + (A/4).floor() + f[M-1]) % 7;
  }
}
