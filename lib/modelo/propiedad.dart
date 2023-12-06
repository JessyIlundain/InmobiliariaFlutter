import 'package:inmobiliaria_flutter/modelo/Cliente.dart';

class Propiedad {
  late int id;
  late int numeroPadron;
  late String tipo;
  late String zona;
  late String direccion;
  late double superficie;
  late String tipoOferta;
  late bool alquiler;
  late bool venta;
  late double precio;
  late Cliente clienteOfertante;
  late bool tieneVisitasAgendadas;
  final List<String> fotos;

  Propiedad({
    required this.id,
    required this.numeroPadron,
    required this.tipo,
    required this.zona,
    required this.direccion,
    required this.superficie,
    required this.tipoOferta,
    required this.precio,
    required this.clienteOfertante,
    this.tieneVisitasAgendadas = false,
    required this.fotos,
  });

  get visitasAgendadas => null;
}
