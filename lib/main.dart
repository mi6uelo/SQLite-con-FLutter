import 'package:flutter/material.dart';
import 'package:computer_crud_sqlite/database/database_helper.dart';
import 'package:computer_crud_sqlite/database/computer_dao.dart';
import 'package:computer_crud_sqlite/models/computer_model.dart';
import 'package:computer_crud_sqlite/bienvenida.dart'; // Importa la pantalla de bienvenida

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const BienvenidaScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final procesadorController = TextEditingController();
  final discoDuroController = TextEditingController();
  final ramController = TextEditingController();
  ComputadoraModel? selectedComputadora; // Para rastrear el registro seleccionado

  List<ComputadoraModel> computadoras = [];
  final dao = ComputerDao();

  @override
  void initState() {
    super.initState();
    _loadComputadoras();
  }

  Future<void> _loadComputadoras() async {
    final data = await dao.readAll();
    setState(() {
      computadoras = data;
    });
  }

  void _clearControllers() {
    procesadorController.clear();
    discoDuroController.clear();
    ramController.clear();
    selectedComputadora = null; // Resetea el registro seleccionado
  }

  @override
  void dispose() {
    procesadorController.dispose();
    discoDuroController.dispose();
    ramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: procesadorController,
                    decoration: const InputDecoration(labelText: 'Procesador'),
                  ),
                  TextField(
                    controller: discoDuroController,
                    decoration: const InputDecoration(labelText: 'Disco Duro'),
                  ),
                  TextField(
                    controller: ramController,
                    decoration: const InputDecoration(labelText: 'RAM'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final procesador = procesadorController.text;
                      final discoDuro = discoDuroController.text;
                      final ram = ramController.text;

                      if (selectedComputadora == null) {
                        // Insertar nueva computadora
                        ComputadoraModel computadora = ComputadoraModel(
                          procesador: procesador,
                          discoDuro: discoDuro,
                          ram: ram,
                        );
                        final id = await dao.insert(computadora);
                        computadora = computadora.copyWith(id: id);
                        setState(() {
                          computadoras.add(computadora);
                        });
                      } else {
                        // Actualizar computadora existente
                        ComputadoraModel updatedComputadora = selectedComputadora!.copyWith(
                          procesador: procesador,
                          discoDuro: discoDuro,
                          ram: ram,
                        );
                        await dao.update(updatedComputadora);
                        setState(() {
                          final index = computadoras.indexWhere((c) => c.id == updatedComputadora.id);
                          computadoras[index] = updatedComputadora;
                        });
                      }

                      _clearControllers();
                    },
                    child: Text(selectedComputadora == null ? 'Agregar Computadora' : 'Actualizar Computadora'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: computadoras.length,
                itemBuilder: (ctx, index) {
                  final computadora = computadoras[index];
                  return ListTile(
                    leading: Text('${computadora.id}'),
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedComputadora = computadora;
                          procesadorController.text = computadora.procesador;
                          discoDuroController.text = computadora.discoDuro;
                          ramController.text = computadora.ram;
                        });
                      },
                      child: Text(
                        'Procesador: ${computadora.procesador}\n'
                            'Disco Duro: ${computadora.discoDuro}\n'
                            'RAM: ${computadora.ram}',
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await dao.delete(computadora);
                        setState(() {
                          computadoras.removeWhere((element) => element.id == computadora.id);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
