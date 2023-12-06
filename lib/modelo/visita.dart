import 'package:inmobiliaria_flutter/modelo/Cliente.dart';
import 'package:inmobiliaria_flutter/modelo/propiedad.dart';

class Visita {
  int id;
  Cliente clienteInteresado;
  Propiedad propiedad;
  DateTime fecha;
  String hora;
  bool cancelada;

  Visita({
    required this.id,
    required this.clienteInteresado,
    required this.propiedad,
    required this.fecha,
    required this.hora,
    required this.cancelada,
  });
}
