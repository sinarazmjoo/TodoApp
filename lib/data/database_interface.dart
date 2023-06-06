abstract class IDatabase {
  Future<void> create<T>(T todo);
  Future<List<T>> readAll<T>();
  Future<T?> read<T>(int id);
  Future<void> update<T>(T todo);
  Future<void> delete<T>(int id);
}
