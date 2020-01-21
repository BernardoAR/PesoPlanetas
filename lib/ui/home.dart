import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controlePeso = TextEditingController();
  double _resultadoFinal = 0.0;
  var _itemSelecionado = '22.9';
  String _nomePlaneta = '';
  final _valores = {
    '22.9': 'Júpiter',
    '1.67': 'Lua',
    '3.72': 'Marte',
    '3.78': 'Mercúrio',
    '11.0': 'Netuno',
    '0.5': '"Plutão"',
    '9.05': 'Saturno',
    '9.8': 'Terra',
    '7.77': 'Urano',
    '0.5': 'Vênus',
  };

  /// Toma conta do valor do dropdown, pegando caso tenha modificações
  void _tomaContaValorDropdown(String valor) {
    setState(() {
      _itemSelecionado = valor;
      _resultadoFinal = _calcularPeso(_controlePeso.text, double.parse(valor));
      if (valor == '1.67') {
        _nomePlaneta =
            'O seu peso na ${_valores[valor]} é: \n${_resultadoFinal.toStringAsFixed(2)}';
      } else {
        _nomePlaneta =
            'O seu peso no Planeta ${_valores[valor]} é: \n${_resultadoFinal.toStringAsFixed(2)}';
      }
    });
  }

  /// Método utilizado para calcular o peso, passando o peso e a gravidadeSuperficial
  double _calcularPeso(String peso, double gravidadeSuperficial) {
    if (double.parse(peso).toString().isNotEmpty && double.parse(peso) > 0) {
      return (double.parse(peso) * gravidadeSuperficial);
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Planeta X'),
          backgroundColor: Colors.black38,
        ),
        backgroundColor: Colors.blueGrey,
        body: Container(
          alignment: Alignment.topCenter,
          child: ListView(
            padding: const EdgeInsets.all(1.5),
            children: <Widget>[
              Image.asset(
                'assets/images/planet.png',
                height: 133.0,
                width: 200.0,
              ),
              Container(
                margin: const EdgeInsets.all(3.0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controlePeso,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'A sua massa',
                            hintText: 'KG',
                            icon: Icon(Icons.person_outline)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton<String>(
                            underline: Container(
                              height: 2,
                              color: Colors.blueAccent,
                            ),
                            items: _valores.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, String> e) =>
                                        DropdownMenuItem<String>(
                                          value: e.key,
                                          child: Text(e.value),
                                        ))
                                .toList(),
                            onChanged: _tomaContaValorDropdown,
                            value: _itemSelecionado)
                      ],
                    ),
                    // Resultado
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                              _controlePeso.text.isEmpty
                                  ? 'Insira sua massa'
                                  : '$_nomePlaneta N',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.4,
                                  fontWeight: FontWeight.w400))),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
