import 'package:flutter/material.dart';

// Widget principal que maneja un formulario con pasos (Stepper).
class FormB extends StatefulWidget {
  const FormB({Key? key}) : super(key: key);

  @override
  State<FormB> createState() => _FormBState();
}

class _FormBState extends State<FormB> {
  // Variable para controlar el paso actual en el Stepper.
  int _currentStep = 0;

  // Controladores para los campos de texto.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  // Método para obtener los pasos del Stepper.
  List<Step> _getSteps() {
    return [
      // Paso 1: Información personal
      Step(
        title: const Text('Pers.'),
        content: Column(
          children: const [
            Text(
              'Personal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Pulsi "Contact" o pulsi el botó de "Continue".'),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      // Paso 2: Información de contacto
      Step(
        title: const Text('Contact'),
        content: Column(
          children: const [
            Text(
              'Contact',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Pulsi "Upload" o pulsi el botó de "Continue".'),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      // Paso 3: Subir información
      Step(
        title: const Text('Upload'),
        isActive: _currentStep >= 2,
        state: _currentStep == 2 ? StepState.indexed : StepState.complete,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Upload',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ingrese su información de contacto a continuación.',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 16),
            // Campo de correo electrónico
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de dirección
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de número de teléfono
            TextField(
              controller: _mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile No',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ];
  }

  // Función para continuar al siguiente paso.
  void _continue() {
    if (_currentStep < _getSteps().length - 1) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  // Función para retroceder al paso anterior.
  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  // Muestra un cuadro de diálogo con los datos ingresados en el formulario.
  void _showFormData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datos Ingresados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${_emailController.text}'),
              Text('Address: ${_addressController.text}'),
              Text('Mobile No: ${_mobileController.text}'),
            ],
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesians Sarrià 24/25'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          Expanded(
            // Paso del Stepper
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              steps: _getSteps(),
              onStepContinue: _continue,
              onStepCancel: _cancel,
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Botón para continuar al siguiente paso
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text('CONTINUE'),
                    ),
                    const SizedBox(width: 8),
                    // Botón para cancelar y retroceder al paso anterior
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('CANCEL'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
