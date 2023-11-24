import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infraestructure/errors/user_error.dart';
import '../../../infraestructure/models/models.dart';

class SearchUseCase {
  final UserRepository _userRepository;
  final LocalRepository _localRepository;

  SearchUseCase(this._userRepository, this._localRepository);

  Future<List<User>> getSearchUsersRemote(Auth auth, String search) async {

    final request =
        SearchInput(accessToken: auth.refreshToken, search: search);

    try {
      return await _userRepository.searchUsers(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<void> saveSearchUsersRecentLocally(List<User> users) async {
    await _localRepository.setKeyValue('recent', users);
  }

  Future<List<User>?> getSearchUsersRecentLocally() async {
    return await _localRepository.getValue<List<User>>('recent');
  }
}
