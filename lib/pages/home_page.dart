import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//enum Divisa {COP,USD,EUR}

class _HomePageState extends State<HomePage> {

  //Divisa? _divisa = Divisa.COP;

  final _value = TextEditingController();
  double _total = 0;

  final List<String> _opciones = ['COP', 'USD', 'EUR', 'MXN', 'GBP', 'JPY'];
  String _opcionSeleccionada1 = 'COP';
  String _opcionSeleccionada2 = 'COP';

  String _resultado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //shape: ,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png',scale: 15,),
            const SizedBox(width: 16,),
            const Text("Conversor de divisas"),
          ],
        ),
        backgroundColor: Color(0xFF62B6CB),
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  const Text("Convertir:",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(0x80CAE9FF),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _opcionSeleccionada1,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? nuevaOpcion) {
                        setState(() {
                          _opcionSeleccionada1 = nuevaOpcion!;
                        });
                      },
                      items: _opciones.map<DropdownMenuItem<String>>((String valor) {
                        return DropdownMenuItem<String>(
                          value: valor,
                          child: Text(valor),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16
                ,
              ),
              TextFormField(
                controller: _value,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: _getDivisa(_opcionSeleccionada1),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if (value!.isEmpty) {
                    return "Dabe digitar un valor.";
                  } else {
                    if (!value.isValidNumber()) {
                      return "El valor no es válido";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Text("En:",
                    style: TextStyle(
                      fontSize: 25,
                    )
                  ),
                  const SizedBox(width:16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(0x80CAE9FF),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _opcionSeleccionada2,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? nuevaOpcion) {
                        setState(() {
                          _opcionSeleccionada2 = nuevaOpcion!;
                        });
                      },
                      items: _opciones.map<DropdownMenuItem<String>>((String valor) {
                        return DropdownMenuItem<String>(
                          value: valor,
                          child: Text(valor),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Color(0xBFBEE9E8)
                ),
                onPressed: (){
                  setState(() {
                    (_value.text == '')
                        ? _resultado = 'No hay un número a calcular'
                        : _resultado = _getTotal(_opcionSeleccionada1, _opcionSeleccionada2);
                  });

                },
                child: const Text(
                  "Calcular",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1B4965)
                  ),
                )
              ),
              const SizedBox(height: 64,),
              Text(_resultado,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w400
                ),

              )
              /*Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.blue[700]!,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }

  String _getDivisa(opcion){
      switch(opcion){
        case 'COP':
          return "Ingrese el valor en COP";
        case 'USD':
          return "Ingrese el valor en USD";
        case 'MXN':
          return "Ingrese el valor en MXN";
        case 'GBP':
          return "Ingrese el valor en GBP";
        case 'JPY':
          return "Ingrese el valor en JPY";
        default:
          return 'Ingrese el valor en EUR';
      }
  }

  String _getTotal(opcion1,opcion2){
    try{
      _total = double.parse(_value.text);
    }catch(e){
      return "El número es inválido";
    }
      switch(opcion2){
        case 'COP':
          switch(opcion1){
            case 'COP':
              return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
            case 'USD':
              _total = double.parse(_value.text)*(4300);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'EUR':
              _total = double.parse(_value.text)*(4900);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'MXN':
              _total = double.parse(_value.text)*(215);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'GBP':
              _total = double.parse(_value.text)*(5600);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'JPY':
              _total = double.parse(_value.text)*(30);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
          }
        case 'USD':
          switch(opcion1){
            case 'COP':
              _total = double.parse(_value.text)*(1/4300);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'USD':
              return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
            case 'EUR':
              _total = double.parse(_value.text)*(1.15);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'MXN':
              _total = double.parse(_value.text)*(1/20);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'GBP':
              _total = double.parse(_value.text)*(1.30);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'JPY':
              _total = double.parse(_value.text)*(1/145);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
          }
        case 'EUR':
          switch(opcion1){
            case 'COP':
              _total = double.parse(_value.text)*(1/4900);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'USD':
              _total = double.parse(_value.text)*(1/1.15);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'EUR':
              return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
            case 'MXN':
              _total = double.parse(_value.text)*(1/22.5);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'GBP':
              _total = double.parse(_value.text)*(1.18);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'JPY':
              _total = double.parse(_value.text)*(1/162);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
          }
        case 'MXN':
          switch(opcion1){
            case 'COP':
              _total = double.parse(_value.text)*(1/215);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'USD':
              _total = double.parse(_value.text)*20;
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'EUR':
              _total = double.parse(_value.text)*22.5;
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'MXN':
              return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
            case 'GBP':
              _total = double.parse(_value.text)*26.2;
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'JPY':
              _total = double.parse(_value.text)*(1/7.2);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
          }
        case 'GBP':
          switch(opcion1){
            case 'COP':
              _total = double.parse(_value.text)*(1/5600);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'USD':
              _total = double.parse(_value.text)*(1/1.30);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'EUR':
              _total = double.parse(_value.text)*(1/1.18);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'MXN':
              _total = double.parse(_value.text)*(26.2);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'GBP':
              return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
            case 'JPY':
            _total = double.parse(_value.text)*(1/190);
            _total = double.parse(_total.toStringAsFixed(2));
            break;
          }
        case 'JPY':
          switch(opcion1){
            case 'COP':
              _total = double.parse(_value.text)*(1/30);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'USD':
              _total = double.parse(_value.text)*(145);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'EUR':
              _total = double.parse(_value.text)*(162);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'MXN':
              _total = double.parse(_value.text)*(7.2);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'GBP':
              _total = double.parse(_value.text)*(190);
              _total = double.parse(_total.toStringAsFixed(2));
              break;
            case 'JPY':
              return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
          }
        default:
          return 'algo hiciste mal';
      }
      return '${_value.text} $_opcionSeleccionada1 es igual a $_total $_opcionSeleccionada2';
  }

}

extension on String {
  bool isValidNumber(){
    return RegExp(r'^[0-9]').hasMatch(this);

  }
}