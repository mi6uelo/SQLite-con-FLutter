import 'package:computer_crud_sqlite/database/database_helper.dart';
import 'package:computer_crud_sqlite/models/computer_model.dart';

class ComputerDao {
  final database = DatabaseHelper.instance.db;

  Future<List<ComputadoraModel>> readAll() async {
    final data = await database.query('computadoras');
    return data.map((e) => ComputadoraModel.fromMap(e)).toList();
  }

  Future<int> insert(ComputadoraModel computadora) async {
    return await database.insert(
      'computadoras',
      {
        'procesador': computadora.procesador,
        'discoDuro': computadora.discoDuro,
        'ram': computadora.ram,
      },
    );
  }

  Future<void> update(ComputadoraModel computadora) async {
    await database.update(
      'computadoras',
      computadora.toMap(),
      where: 'id = ?',
      whereArgs: [computadora.id],
    );
  }

  Future<void> delete(ComputadoraModel computadora) async {
    await database.delete(
      'computadoras',
      where: 'id = ?',
      whereArgs: [computadora.id],
    );
  }
}
