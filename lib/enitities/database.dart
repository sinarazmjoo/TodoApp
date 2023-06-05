import 'package:bloc_todo_app/enitities/database_interface.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bloc_todo_app/models/todo.dart';
import 'package:isar/isar.dart';

class Database implements IDatabase {
  late Future<Isar> db;

  Database() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return Isar.open(
        [TodoSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(
      Isar.getInstance(),
    );
  }

  @override
  Future<void> create<T>(T t) async {
    final isar = await db;
    await isar.writeTxn(() => isar.collection<T>().put(t));
  }

  @override
  Future<List<T>> readAll<T>() async {
    final isar = await db;
    return await isar.writeTxn(() => isar.collection<T>().where().findAll());
  }

  @override
  Future<T?> read<T>(int id) async {
    final isar = await db;
    return await isar.writeTxn(
      () => isar.collection<T>().buildQuery<T>(
        whereClauses: [IdWhereClause.equalTo(value: id)],
      ).findFirst(),
    );
  }

  @override
  Future<void> update<T>(T t) async {
    final isar = await db;
    await isar.writeTxn(() => isar.collection<T>().put(t));
  }

  @override
  Future<void> delete<T>(int id) async {
    final isar = await db;
    isar.writeTxn(() => isar.collection<T>().delete(id));
  }
}
