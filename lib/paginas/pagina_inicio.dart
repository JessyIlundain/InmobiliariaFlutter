import 'package:flutter/material.dart';
import 'package:inmobiliaria_flutter/modelo/cliente.dart';
import 'package:inmobiliaria_flutter/paginas/pagina_cliente.dart';
import 'package:inmobiliaria_flutter/utilidades/calendario.dart';

class PaginaInicio extends StatelessWidget {
  final String titulo;
  final List<Cliente> clientes;

  const PaginaInicio({super.key, required this.titulo, required this.clientes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'imagenes/logoCasa.png',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Text(titulo),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Visitas agendadas',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 10, 100, 128),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () {
              _mostrarCalendario(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Ver visitas por fecha',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ExpansionTile(
              title: Text(
                'Clientes',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              backgroundColor: Colors.white,
              children: [
                ListTile(
                  title: Text(
                    'Registrar Cliente',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/cliente');
                  },
                ),
                ListTile(
                  title: Text(
                    'Buscar Cliente',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(clientes: clientes),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Listar Clientes',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/cliente');
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Agentes',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              backgroundColor: Colors.white,
              children: [
                ListTile(
                  title: Text(
                    'Registrar Agente',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/agente');
                  },
                ),
                ListTile(
                  title: Text(
                    'Buscar Agente',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/agente');
                  },
                ),
                ListTile(
                  title: Text(
                    'Listar Agente',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/agente');
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Propiedades',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              backgroundColor: Colors.white,
              children: [
                ListTile(
                  title: Text(
                    'Registrar una propiedad',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/propiedad');
                  },
                ),
                ListTile(
                  title: Text(
                    'Ver todas las propiedades',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/propiedad');
                  },
                ),
                ListTile(
                  title: Text(
                    'Buscar Propiedad',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/propiedad');
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Visitas',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              backgroundColor: Colors.white,
              children: [
                ListTile(
                  title: Text(
                    'Agendar Visita',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Cancelar Visita',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarCalendario(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Calendario(),
    );
  }
}
