import 'package:flutter/material.dart';
import 'package:inmobiliaria_flutter/modelo/propiedad.dart';

class ListaPropiedades extends StatelessWidget {
  final List<Propiedad> propiedades;

  const ListaPropiedades({Key? key, required this.propiedades}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Propiedades'),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView.builder(
          itemCount: propiedades.length,
          itemBuilder: (BuildContext context, int index) {
            final propiedad = propiedades[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mostrar la primera imagen de la propiedad
                  propiedad.fotos.isNotEmpty
                      ? Image.asset(
                          'imagenes/${propiedad.fotos[0]}',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 200,
                          color: Colors.grey, // Otra opción si no hay imagen
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          propiedad.direccion,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tipo: ${propiedad.tipo}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Zona: ${propiedad.zona}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Superficie: ${propiedad.superficie} m²',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Precio: \$${propiedad.precio.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  // Mostrar otras fotos de la propiedad
                  if (propiedad.fotos.length > 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: propiedad.fotos
                            .skip(1) // Omitir la primera foto que ya se mostró
                            .take(3) // Mostrar hasta 3 fotos adicionales
                            .map((foto) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      'imagenes/$foto',
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}