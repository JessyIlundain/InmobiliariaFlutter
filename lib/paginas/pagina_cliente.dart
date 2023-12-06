import 'package:flutter/material.dart';
import 'package:inmobiliaria_flutter/modelo/cliente.dart';

class PaginaCliente extends StatefulWidget {
  const PaginaCliente({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaginaClienteState createState() => _PaginaClienteState();
}

class _PaginaClienteState extends State<PaginaCliente> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  List<Cliente> clientes = [];
  List<Cliente> filteredClientes = [];

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldMessengerKey,
        appBar: AppBar(
          title: const Text('Clientes'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre Completo',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        cursorColor: Theme.of(context).primaryColor,
                        cursorOpacityAnimates: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre completo';
                          }
                          if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$')
                              .hasMatch(value)) {
                            return 'El nombre solo debe contener letras';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: telefonoController,
                        decoration: InputDecoration(
                          labelText: 'Teléfono de Contacto',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        cursorColor: Theme.of(context).primaryColor,
                        cursorOpacityAnimates: false,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el número de teléfono';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'El número de teléfono solo debe contener números';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            registrarCliente(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text(
                          'Registrar Cliente',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                /*Text(
                  'Clientes Registrados:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white),
                ),
                Column(
                  children: filteredClientes.isNotEmpty
                      ? filteredClientes
                          .map((cliente) => Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  title: Text(
                                    cliente.nombreCompleto,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  subtitle: Text(
                                    cliente.telefonoContacto,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          modificarCliente(filteredClientes
                                              .indexOf(cliente));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          eliminarCliente(filteredClientes
                                              .indexOf(cliente));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList()
                      : clientes
                          .map((cliente) => Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(cliente.nombreCompleto),
                                  subtitle: Text(cliente.telefonoContacto),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          modificarCliente(
                                              clientes.indexOf(cliente));
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          eliminarCliente(
                                              clientes.indexOf(cliente));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                ),*/
              ],
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
      ),
    );
  }

  void registrarCliente(BuildContext context) {
    int id = DateTime.now().microsecondsSinceEpoch;
    Cliente nuevoCliente = Cliente(
      id: id,
      nombreCompleto: nombreController.text,
      telefonoContacto: telefonoController.text,
    );

    setState(() {
      clientes.add(nuevoCliente);
      filteredClientes = clientes;
    });

    nombreController.clear();
    telefonoController.clear();
    searchController.clear();
    FocusScope.of(context).requestFocus(FocusNode());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Éxito',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text('Cliente registrado con éxito'),
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
  }

  void eliminarCliente(int index) {
    setState(() {
      clientes.removeAt(index);
      filteredClientes = clientes;
    });
  }

  void modificarCliente(int index) {
    TextEditingController nombreModController =
        TextEditingController(text: clientes[index].nombreCompleto);
    TextEditingController telefonoModController =
        TextEditingController(text: clientes[index].telefonoContacto);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Modificar Cliente',
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: index == 0
                        ? nombreModController
                        : telefonoModController,
                    decoration: InputDecoration(
                      labelText: index == 0
                          ? 'Nombre Completo'
                          : 'Teléfono de Contacto',
                    ),
                    keyboardType:
                        index == 1 ? TextInputType.phone : TextInputType.text,
                    maxLines: 1,
                  ),
                );
              },
            ),
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
                setState(() {
                  clientes[index].nombreCompleto = nombreModController.text;
                  clientes[index].telefonoContacto = telefonoModController.text;
                  filteredClientes = clientes;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Cliente> clientes;

  CustomSearchDelegate({required this.clientes});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = clientes
        .where((cliente) =>
            cliente.nombreCompleto.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.isEmpty) {
      Future.delayed(Duration.zero, () {
        query = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se encontró el cliente'),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la búsqueda'),
        actions: [
          IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            close(context, '');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            alignment: Alignment.center,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              child: const Icon(Icons.home),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final cliente = results[index];
          return ListTile(
            title: Text(cliente.nombreCompleto),
            subtitle: Text(cliente.telefonoContacto),
            onTap: () {
              close(context, cliente.nombreCompleto);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = clientes
        .where((cliente) =>
            cliente.nombreCompleto.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la búsqueda'),
        actions: [
          IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            close(context, '');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              child: const Icon(Icons.home),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final cliente = results[index];
          return ListTile(
            title: Text(cliente.nombreCompleto),
            subtitle: Text(cliente.telefonoContacto),
            onTap: () {
              close(context, cliente.nombreCompleto);
            },
          );
        },
      ),
    );
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
}
