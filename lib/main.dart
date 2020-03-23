import 'package:alcool_gasolina_flutter/widgets/input.widget.dart';
import 'package:alcool_gasolina_flutter/widgets/loading-button.widget.dart';
import 'package:alcool_gasolina_flutter/widgets/logo.widget.dart';
import 'package:alcool_gasolina_flutter/widgets/submit-form.dart';
import 'package:alcool_gasolina_flutter/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Álcool ou Gasolina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  var _gasolinaCtrl = new MoneyMaskedTextController();
  var _alcoolCtrl = new MoneyMaskedTextController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          Logo(),
          Success(
            reset: () {},
            result: "Compensa utilizar x",
          ),
          SubmitForm(
              gasolinaCtrl: _gasolinaCtrl,
              alcoolCtrl: _alcoolCtrl,
              busy: false,
              submitFunc: () {}),
        ],
      ),
    );
  }
}
