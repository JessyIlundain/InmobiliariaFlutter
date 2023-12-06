import 'package:flutter/material.dart';
import 'package:inmobiliaria_flutter/paginas/pagina_cliente.dart';
import 'package:inmobiliaria_flutter/paginas/pagina_inicio.dart';
import 'package:inmobiliaria_flutter/paginas/pagina_propiedad.dart';

void main() {
  runApp(const Aplicacion());
}

class Aplicacion extends StatelessWidget {
  const Aplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inmobiliaria',
      theme: ThemeData.dark().copyWith(
      primaryColor: const Color.fromARGB(255, 10, 100, 128),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 10, 100, 128),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),       
      home: const PaginaInicio(titulo: 'Inmobiliaria', clientes: [],),
      routes: {
        '/cliente': (context) =>  PaginaCliente(),
        '/propiedad': (context) =>  PaginaPropiedad(),
      },
    );
  }
  
}

