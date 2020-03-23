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
  Color _color = Colors.deepPurple;
  var _gasolinaCtrl = new MoneyMaskedTextController();
  var _alcoolCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar álcool.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200,
        ),
        color: _color,
        child: ListView(
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
      ),
    );
  }

  Future calculate() {
    double alcool =
        double.parse(_alcoolCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;

    double gasolina =
        double.parse(_gasolinaCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;

    double res = alcool / gasolina;

    setState(() {
      _color = Colors.deepPurpleAccent;
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
      _color = Colors.deepPurple;
    });
  }
}
