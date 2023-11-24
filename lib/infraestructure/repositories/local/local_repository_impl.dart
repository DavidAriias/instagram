import '../../../domain/datasources/datasource.dart';
import '../../../domain/repositories/repositories.dart';

class LocalRepositoryImpl extends LocalRepository {
  final LocalDatasource _localDatasource;

  LocalRepositoryImpl(this._localDatasource);

  @override
  Future<T?> getValue<T>(String key) async {
    return _localDatasource.getValue(key);
  }

  @override
  Future<bool> removeKey(String key) async {
    return _localDatasource.removeKey(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    return _localDatasource.setKeyValue(key, value);
  }
}
