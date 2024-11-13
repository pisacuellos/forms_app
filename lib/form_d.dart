import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormD extends StatefulWidget {
  const FormD({Key? key}) : super(key: key);

  @override
  State<FormD> createState() => _FormDState();
}

class _FormDState extends State<FormD> {
  // GlobalKey para acceder al estado del formulario y validación.
  final _formKey = GlobalKey<FormBuilderState>();

  // Lista de países para la funcionalidad de autocompletar.
  final _countries = [
    'Angola', 'Argentina', 'Australia', 'Austria', 'Brazil', 'Canada', 'China',
    'Colombia', 'France', 'Germany', 'India', 'Japan', 'Spain', 'United Kingdom', 'United States'
  ];

  // Controlador de texto para el campo de autocompletar.
  final TextEditingController _autocompleteController = TextEditingController();
  // Lista de países filtrados basados en la búsqueda del usuario.
  List<String> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    // Inicializa la lista de países filtrados con la lista completa al inicio.
    _filteredCountries = _countries;
  }

  // Método que se llama cada vez que el usuario cambia el texto en el campo de búsqueda.
  void _onSearchChanged(String query) {
    setState(() {
      // Filtra los países según la búsqueda del usuario.
      _filteredCountries = _countries
          .where((country) => country.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

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
                // Campo de Autocompletado (Autocomplete)
                _buildLabeledContainer(
                  label: 'Autocomplete',
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _autocompleteController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: _onSearchChanged,
                      ),
                      // Si hay coincidencias, muestra los resultados de autocompletar.
                      if (_filteredCountries.isNotEmpty && _autocompleteController.text.isNotEmpty)
                        ListView(
                          shrinkWrap: true,
                          children: _filteredCountries.map((country) {
                            return ListTile(
                              title: Text(country),
                              onTap: () {
                                _autocompleteController.text = country;
                                setState(() {
                                  _filteredCountries = [];  // Cierra la lista de sugerencias al seleccionar una opción.
                                });
                              },
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Campo para seleccionar fecha (Date Picker)
                _buildLabeledContainer(
                  label: 'Date Picker',
                  child: FormBuilderDateTimePicker(
                    name: 'date_picker',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputType: InputType.date, // Se selecciona solo la fecha (sin hora).
                  ),
                ),
                const SizedBox(height: 16),

                // Campo para seleccionar un rango de fechas (Date Range Picker)
                _buildLabeledContainer(
                  label: 'Date Range',
                  child: FormBuilderDateRangePicker(
                    name: 'date_range',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Campo para seleccionar hora (Time Picker)
                _buildLabeledContainer(
                  label: 'Time Picker',
                  child: FormBuilderDateTimePicker(
                    name: 'time_picker',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputType: InputType.time, // Se selecciona solo la hora.
                  ),
                ),
                const SizedBox(height: 16),

                // Campo para seleccionar chips (Filter Chip)
                _buildLabeledContainer(
                  label: 'Input Chips (Filter Chip)',
                  child: FormBuilderFilterChip(
                    name: 'input_chips',
                    decoration: const InputDecoration(border: InputBorder.none),
                    options: const [
                      FormBuilderChipOption(value: 'HTML', child: Text('HTML')),
                      FormBuilderChipOption(value: 'CSS', child: Text('CSS')),
                      FormBuilderChipOption(value: 'React', child: Text('React')),
                      FormBuilderChipOption(value: 'Dart', child: Text('Dart')),
                      FormBuilderChipOption(value: 'TypeScript', child: Text('TypeScript')),
                      FormBuilderChipOption(value: 'Angular', child: Text('Angular')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Botón flotante para enviar los datos del formulario
                FloatingActionButton(
                  onPressed: () {
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

  // Método auxiliar para crear un contenedor con una etiqueta y un widget hijo.
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
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
