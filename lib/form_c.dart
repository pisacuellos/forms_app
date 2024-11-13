import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Widget principal que maneja un formulario utilizando FormBuilder.
class FormC extends StatefulWidget {
  const FormC({Key? key}) : super(key: key);

  @override
  State<FormC> createState() => _FormCState();
}

class _FormCState extends State<FormC> {
  // GlobalKey para acceder al estado del formulario y validación.
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesians Sarrià 24/25'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Campo ChoiceChip: permite seleccionar una opción
                _buildLabeledContainer(
                  label: 'Choice Chips',
                  child: FormBuilderChoiceChip(
                    name: 'choice_chip',
                    decoration: const InputDecoration(border: InputBorder.none),
                    options: [
                      FormBuilderChipOption(
                        value: 'Flutter',
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.flutter_dash, color: Colors.blue, size: 18),
                              SizedBox(width: 5),
                              Text(
                                'Flutter',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FormBuilderChipOption(
                        value: 'Android',
                        child: Center(
                          child: Text(
                            'Android',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      FormBuilderChipOption(
                        value: 'Chrome OS',
                        child: Center(
                          child: Text(
                            'Chrome OS',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Switch: permite activar o desactivar una opción
                _buildLabeledContainer(
                  label: 'Switch',
                  child: FormBuilderSwitch(
                    name: 'switch',
                    title: const Text('This is a switch'),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Text Field: permite ingresar texto
                _buildLabeledContainer(
                  label: 'Text Field',
                  child: FormBuilderTextField(
                    name: 'text_field',
                    decoration: const InputDecoration(
                      labelText: 'Enter text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Dropdown: permite seleccionar una opción del desplegable
                _buildLabeledContainer(
                  label: 'Dropdown Field',
                  child: FormBuilderDropdown(
                    name: 'dropdown',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: ['Option 1', 'Option 2', 'Option 3']
                        .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Radio Group: permite seleccionar una opción entre varias
                _buildLabeledContainer(
                  label: 'Radio Group Model',
                  child: FormBuilderRadioGroup(
                    name: 'radio_group',
                    decoration: const InputDecoration(border: InputBorder.none),
                    options: const [
                      FormBuilderFieldOption(value: 'Option 1', child: Text('Option 1')),
                      FormBuilderFieldOption(value: 'Option 2', child: Text('Option 2')),
                      FormBuilderFieldOption(value: 'Option 3', child: Text('Option 3')),
                      FormBuilderFieldOption(value: 'Option 4', child: Text('Option 4')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Botón flotante para mostrar los datos del formulario
                FloatingActionButton(
                  onPressed: () {
                    // Valida el formulario y muestra los datos ingresados
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState?.value;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Form Data'),
                            content: Text(formData.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  backgroundColor: Colors.blue[200],
                  child: const Icon(Icons.upload, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para crear un contenedor con una etiqueta y un widget hijo.
  Widget _buildLabeledContainer({required String label, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiqueta del campo
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          // Widget hijo (campo de formulario)
          child,
        ],
      ),
    );
  }
}
