import 'package:flutter/material.dart';
import 'package:inmobiliaria_flutter/modelo/Cliente.dart';
import 'package:inmobiliaria_flutter/modelo/propiedad.dart';

class PaginaPropiedad extends StatefulWidget {
  const PaginaPropiedad({super.key});

  @override
  PaginaPropiedadState createState() => PaginaPropiedadState();
}

class PaginaPropiedadState extends State<PaginaPropiedad> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numeroPadronController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController zonaController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController superficieController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController tipoOfertaController =
      TextEditingController(text: 'Alquiler');

  List<Propiedad> propiedades = [];
  List<Propiedad> filteredPropiedades = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Propiedades'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTextFormField(
                  controller: numeroPadronController,
                  labelText: 'Número de Padrón',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el número de padrón';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                buildTextFormField(
                  controller: tipoController,
                  labelText: 'Tipo de Propiedad',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el tipo de propiedad';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: zonaController,
                  labelText: 'Zona',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la zona';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: direccionController,
                  labelText: 'Dirección',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la dirección';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: superficieController,
                  labelText: 'Superficie (m²)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la superficie';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: precioController,
                  labelText: 'Precio en Dólares',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el precio';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: clienteController,
                  labelText: 'Cliente Ofertante',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el cliente ofertante';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildTipoOfertaSelection(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      registrarPropiedad();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  child: const Text('Registrar Propiedad'),
                ),
                const SizedBox(height: 16),
                /* const Text(
                  'Propiedades Registradas:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredPropiedades.length,
                  itemBuilder: (context, index) {
                    return buildPropiedadCard(filteredPropiedades[index]);
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.home),
      ),
    );
  }

  Widget buildTipoOfertaSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipo de Oferta', style: TextStyle(fontSize: 16)),
        Row(
          children: [
            Radio<String>(
              value: 'Alquiler',
              groupValue: tipoOfertaController.text,
              onChanged: (String? value) {
                setState(() {
                  tipoOfertaController.text = value!;
                });
              },
            ),
            const Text('Alquiler'),
            Radio<String>(
              value: 'Venta',
              groupValue: tipoOfertaController.text,
              onChanged: (String? value) {
                setState(() {
                  tipoOfertaController.text = value!;
                });
              },
            ),
            const Text('Venta'),
          ],
        ),
      ],
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: keyboardType,
      validator: validator,
      maxLines: 1,
    );
  }

  Widget buildPropiedadCard(Propiedad propiedad) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(propiedad.direccion),
        subtitle: Text(
          'Tipo: ${propiedad.tipo}, Zona: ${propiedad.zona}, Precio: \$${propiedad.precio}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                modificarPropiedad(propiedad);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                eliminarPropiedad(propiedad);
              },
            ),
          ],
        ),
      ),
    );
  }

  void registrarPropiedad() {
    try {
      int id = DateTime.now().microsecondsSinceEpoch;
      Propiedad nuevaPropiedad = Propiedad(
        id: id,
        numeroPadron: int.parse(numeroPadronController.text),
        tipo: tipoController.text,
        zona: zonaController.text,
        direccion: direccionController.text,
        superficie: double.parse(superficieController.text),
        tipoOferta: tipoOfertaController.text,
        precio: double.parse(precioController.text),
        clienteOfertante: Cliente(
          nombreCompleto: clienteController.text,
          telefonoContacto: '',
          id: 0,
        ),
        fotos: [],
      );

      setState(() {
        propiedades.add(nuevaPropiedad);
        filteredPropiedades = propiedades;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Éxito',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text('Propiedad registrada con éssito'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );

      limpiarYDesenfocar();
    } catch (e) {
      mostrarError('Error al intentar registrar la propiedad: $e');
    }
  }

  void eliminarPropiedad(Propiedad propiedad) {
    if (propiedad.tieneVisitasAgendadas) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Advertencia'),
            content: const Text(
              'Esta propiedad tiene visitas agendadas. ¿Seguro que desea eliminarla?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  eliminarPropiedadConfirmed(propiedad);
                  Navigator.of(context).pop();
                },
                child: const Text('Eliminar'),
              ),
            ],
          );
        },
      );
    } else {
      eliminarPropiedadConfirmed(propiedad);
    }
  }

  void eliminarPropiedadConfirmed(Propiedad propiedad) {
    setState(() {
      propiedades.remove(propiedad);
      filteredPropiedades = propiedades;
    });

    mostrarSnackBar('Propiedad eliminada con éxito');
  }

  void modificarPropiedad(Propiedad propiedad) {
    numeroPadronController.text = propiedad.numeroPadron.toString();
    tipoController.text = propiedad.tipo;
    zonaController.text = propiedad.zona;
    direccionController.text = propiedad.direccion;
    superficieController.text = propiedad.superficie.toString();
    tipoOfertaController.text =
        propiedad.tipoOferta; // Establecer el tipo de oferta
    precioController.text = propiedad.precio.toString();
    clienteController.text = propiedad.clienteOfertante.nombreCompleto;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modificar Propiedad'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFormField(
                  controller: numeroPadronController,
                  labelText: 'Número de Padrón',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el número de padrón';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                buildTextFormField(
                  controller: tipoController,
                  labelText: 'Tipo de Propiedad',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el tipo de propiedad';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: zonaController,
                  labelText: 'Zona',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la zona';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: direccionController,
                  labelText: 'Dirección',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la dirección';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: superficieController,
                  labelText: 'Superficie (m²)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la superficie';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: precioController,
                  labelText: 'Precio en Dólares',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el precio';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: clienteController,
                  labelText: 'Cliente Ofertante',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el cliente ofertante';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildTipoOfertaSelection(), // Mostrar la selección de tipo de oferta
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      aplicarCambios(propiedad);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Guardar Cambios'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 


  void aplicarCambios(Propiedad propiedad) {
    propiedad.numeroPadron = int.parse(numeroPadronController.text);
    propiedad.tipo = tipoController.text;
    propiedad.zona = zonaController.text;
    propiedad.direccion = direccionController.text;
    propiedad.superficie = double.parse(superficieController.text);
    propiedad.tipoOferta = tipoOfertaController.text;
    propiedad.precio = double.parse(precioController.text);
    propiedad.clienteOfertante = Cliente(
      nombreCompleto: clienteController.text,
      telefonoContacto: '',
      id: 0,
    );

    setState(() {
      // Reemplaza la propiedad existente con la propiedad modificada
      propiedades[propiedades.indexOf(propiedad)] = propiedad;
      filteredPropiedades = propiedades;
    });

    limpiarYDesenfocar();
  }

  void limpiarYDesenfocar() {
    numeroPadronController.clear();
    tipoController.clear();
    zonaController.clear();
    direccionController.clear();
    superficieController.clear();
    tipoOfertaController.clear();
    precioController.clear();
    clienteController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).primaryColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Theme.of(context).primaryColor,
        filled: true,
        contentPadding: const EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
}

