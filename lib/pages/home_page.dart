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

  final List<String> _opciones = ['COP', 'USD', 'EUR'];
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                      color: Color(0xF1EDEDFF),
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
                  /*if (value!.isEmpty) {
                    return "Dabe digitar un correo electrónico";
                  } else {
                    if (!value!.isValidEmail()) {
                      return "El correo no es válido";
                    }
                  }*/
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
                      color: Color(0xF1EDEDFF),
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
                onPressed: (){
                  setState(() {
                    (_value.text == '')
                        ? _resultado = 'No hay un número a calcular'
                        : _resultado = _getTotal(_opcionSeleccionada1, _opcionSeleccionada2);
                  });

                },
                child: const Text("Calcular")
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
        default:
          return 'Ingrese el valor en EUR';
      }
  }

  String _getTotal(opcion1,opcion2){
      switch(opcion2){
        case 'COP':
          if(opcion1 == 'COP'){
            return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
          }
          else if(opcion1 == 'USD'){
            _total = int.parse(_value.text)*4300;
            _total = double.parse(_total.toStringAsFixed(3));
            break;
          }
          else{
            _total = double.parse(_value.text)*4900;
            _total = double.parse(_total.toStringAsFixed(3));
            break;
          }
        case 'USD':
          if(opcion1 == 'USD'){
            return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
          }
          else if(opcion1 == 'COP'){
            _total = double.parse(_value.text)*(1/4300);
            _total = double.parse(_total.toStringAsFixed(3));

            break;
          }
          else{
            _total = double.parse(_value.text)*1.15;
            _total = double.parse(_total.toStringAsFixed(3));
            break;
          }
        case 'EUR':
          if(opcion1 == 'EUR'){
            return 'El resultado es el mismo número. Por favor seleccione una conversión válida.';
          }
          else if(opcion1 == 'USD'){
            _total = double.parse(_value.text)*(1/1.15);
            _total = double.parse(_total.toStringAsFixed(3));
            break;
          }
          else{
            _total = double.parse(_value.text)*(1/4900);
            _total = double.parse(_total.toStringAsFixed(3));
            break;
          }
        default:
          return 'algo hiciste mal';
      }
      return '${_value.text} $_opcionSeleccionada1 es igual a $_total $_opcionSeleccionada2';
  }

}
