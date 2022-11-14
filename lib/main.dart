import "package:flutter/material.dart";
import "dart:math";
import "currecy_format.dart";
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
    title: 'Discount Calculator',
    theme: ThemeData.dark().copyWith(
      primaryColor: Color.fromARGB(255, 15, 96, 121),
      scaffoldBackgroundColor: Color.fromARGB(255, 10, 69, 87),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 15, 96, 121),
        centerTitle: true,
        elevation: 0.0,
      ),
    ),
    home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _hasil = "";
  String _jumlahDiskon = "";
  double _currentSliderValue = 10;
  TextEditingController sliderController = TextEditingController();

  final TextEditingController _hargaAsli = TextEditingController();
  final TextEditingController _nilaiDiskon = TextEditingController();

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalkulator Diskon"), elevation: 0.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              child: Container(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 11, 137, 142),
                backgroundBlendMode: BlendMode.modulate,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _hargaAsli,
                    decoration:
                        InputDecoration(labelText: "Harga sebelum diskon (Rp)"),
                    keyboardType: TextInputType.number,
                  )),
            ]),
          )),
          Container(
            child: Container(
              margin:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              padding: const EdgeInsets.only(
                  left: 1.0, right: 1.0, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 11, 137, 142),
                  backgroundBlendMode: BlendMode.modulate,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 20.0),
                    // color: Colors.red,
                    child: Text(
                      "Persentase Diskon",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 0.0),
                    child: Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                          sliderController.text =
                              _currentSliderValue.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 20.0),
                    child: Text(
                      _currentSliderValue.round().toString() + "%",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.only(left: 1.0, right: 1.0, top: 15),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 11, 137, 142),
                  backgroundBlendMode: BlendMode.modulate,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Flexible(
                      fit: FlexFit.loose,
                      child: FlatButton(
                          onPressed: _hasilDiskon,
                          child: Text("Hitung"),
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                              left: 54.0,
                              right: 54.0))),
                  diskonResultsWidget(_hasil),
                  diskonResultsWidget2(_jumlahDiskon)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _hasilDiskon() {
    double A = 0.0;
    double x = 0;
    int P = int.parse(_hargaAsli.text);
    double r = _currentSliderValue / 100;
    A = P - (P * r);
    x = P - A;

    _jumlahDiskon = CurrencyFormat.convertToIdr(x, 2);
    _hasil = CurrencyFormat.convertToIdr(A, 2);

    setState(() {});
  }

  Widget diskonResultsWidget(hasilDiskon) {
    bool canShow = false;
    String _hasil = hasilDiskon;

    if (_hasil.length > 0) {
      canShow = true;
    }
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        child: canShow
            ? Column(children: [
                Text("Harga setelah diskon",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Container(
                    child: Text(_hasil,
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold)))
              ])
            : Container());
  }

  Widget diskonResultsWidget2(hasilDiskon) {
    bool canShow = false;
    String _jumlahDiskon = hasilDiskon;

    if (_jumlahDiskon.length > 0) {
      canShow = true;
    }
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        child: canShow
            ? Column(children: [
                Text("Uang yang disimpan",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                    child: Text(_jumlahDiskon,
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold)))
              ])
            : Container());
  }
}
