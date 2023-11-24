import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';

import '../../../domain/entities/entities.dart';

final searchProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, List<User>>((ref) {
  return SearchNotifier(searchUseCase, authUseCase);
});

class SearchNotifier extends StateNotifier<List<User>> {
  final SearchUseCase _userUseCase;
  final AuthUseCase _authUseCase;
  SearchNotifier(this._userUseCase, this._authUseCase) : super([]);

  Future<void> getSearchUsersRemote(String search) async {
    if (search.isEmpty) {
      state = [];
      return;
    }
    final auth = await _authUseCase.getLocalAuth();
    state = await _userUseCase.getSearchUsersRemote(auth!, search);
  }

  Future<void> getSearchUsersLocal() async {
    
  }
}
