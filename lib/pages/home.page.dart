import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:alcool_gasolina_flutter/widgets/logo.widget.dart';
import 'package:alcool_gasolina_flutter/widgets/submit-form.dart';
import 'package:alcool_gasolina_flutter/widgets/success.widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _gasolinaCtrl = new MoneyMaskedTextController();
  var _alcoolCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar álcool.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          Logo(),
          _completed
              ? Success(
                  reset: reset,
                  result: _resultText,
                )
              : SubmitForm(
                  gasolinaCtrl: _gasolinaCtrl,
                  alcoolCtrl: _alcoolCtrl,
                  busy: _busy,
                  submitFunc: calculate,
                ),
        ],
      ),
    );
  }

  Future calculate() {
    print('entrei aqui');

    double alcool =
        double.parse(_alcoolCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;

    double gasolina =
        double.parse(_gasolinaCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;

    double res = alcool / gasolina;

    setState(() {
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (res >= 0.7) {
          _resultText = "Compensa utilizar Gasolina.";
        } else {
          _resultText = "Compensa utilizar Álcool.";
        }

        _completed = true;
        _busy = false;
      });
    });
  }

  reset() {
    setState(() {
      _alcoolCtrl = new MoneyMaskedTextController();
      _gasolinaCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
    });
  }
}
