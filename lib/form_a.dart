import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Widget principal que representa el formulario de conducción.
class FormA extends StatefulWidget {
  const FormA({super.key});

  @override
  State<FormA> createState() => _FormAState();
}

class _FormAState extends State<FormA> {
  // Llave global para manejar el estado del FormBuilder.
  final _formKey = GlobalKey<FormBuilderState>();

  // Muestra un cuadro de diálogo con los datos ingresados si la validación es exitosa.
  void _showFormData() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Datos Ingresados'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formData!.entries.map((entry) {
                return Text('${entry.key}: ${entry.value}');
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print("Validation failed"); // Mensaje en consola si falla la validación.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesians Sarrià 24/25'), // Título del formulario.
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey, // Asigna la llave global al FormBuilder.
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Título del formulario
                const Text(
                  'Driving Form',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Form example',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please provide the speed of vehicle?',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'please select one option given below',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                // Pregunta sobre la velocidad del vehículo con opciones de radio.
                FormBuilderRadioGroup<String>(
                  name: 'speed',
                  options: [
                    FormBuilderFieldOption(value: 'above 40km/h', child: Text('above 40km/h')),
                    FormBuilderFieldOption(value: 'below 40km/h', child: Text('below 40km/h')),
                    FormBuilderFieldOption(value: '0km/h', child: Text('0km/h')),
                  ],
                ),
                const SizedBox(height: 20),
                // Campo para ingresar comentarios.
                const Text('Enter remarks'),
                FormBuilderTextField(
                  name: 'remarks',
                  decoration: const InputDecoration(
                    hintText: 'Enter your remarks',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please provide the high speed of vehicle?',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'please select one option given below',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                // Pregunta sobre la velocidad máxima alcanzada con un menú desplegable.
                FormBuilderDropdown<String>(
                  name: 'high_speed',
                  decoration: const InputDecoration(
                    hintText: 'Select option',
                  ),
                  items: ['20km/h', '30km/h', '40km/h', '50km/h']
                      .map((speed) => DropdownMenuItem(
                    value: speed,
                    child: Text(speed),
                  )).toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please provide the speed of vehicle past 1 hour?',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'please select one or more options given below',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                // Pregunta sobre la velocidad en la última hora con selección múltiple.
                FormBuilderCheckboxGroup<String>(
                  name: 'past_speed',
                  options: [
                    FormBuilderFieldOption(value: '20km/h'),
                    FormBuilderFieldOption(value: '30km/h'),
                    FormBuilderFieldOption(value: '40km/h'),
                    FormBuilderFieldOption(value: '50km/h'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // Botón flotante para mostrar los datos ingresados al presionarlo.
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormData,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.upload),
      ),
    );
  }
}
