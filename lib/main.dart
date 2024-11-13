import 'package:flutter/material.dart';
import 'package:forms_app/form_a.dart';
import 'package:forms_app/form_b.dart';
import 'package:forms_app/form_c.dart';
import 'package:forms_app/form_d.dart';

// Punto de entrada de la aplicación Flutter.
void main() => runApp(const MyApp());

// Clase principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye la aplicación y define la configuración de rutas.
    return MaterialApp(
      title: 'Formularios',
      initialRoute: '/', // Ruta inicial que muestra la MainPage.
      routes: {
        // Definición de rutas para navegar entre páginas.
        '/': (context) => const MainPage(),
        '/FormA': (context) => const FormA(),
        '/FormB': (context) => const FormB(),
        '/FormC': (context) => const FormC(),
        '/FormD': (context) => const FormD(),
      },
    );
  }
}

// Página principal que muestra botones para navegar a diferentes formularios.
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal - Formularios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Botón para navegar a FormA.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FormA');
              },
              child: const Text('Form A'),
            ),
            // Botón para navegar a FormB.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FormB');
              },
              child: const Text('Form B'),
            ),
            // Botón para navegar a FormC.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FormC');
              },
              child: const Text('Form C'),
            ),
            // Botón para navegar a FormD.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FormD');
              },
              child: const Text('Form D'),
            ),
          ],
        ),
      ),
    );
  }
}
