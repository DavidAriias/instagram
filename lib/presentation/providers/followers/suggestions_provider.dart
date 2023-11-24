import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/domain/entities/entities.dart';

import '../../../config/dependenciesInjection/instances_container.dart';


final suggestionsProvider = StateNotifierProvider<SuggestionsNotifier, List<User>>((ref) {
   return SuggestionsNotifier(authUseCase, userUseCase);
});

class SuggestionsNotifier extends StateNotifier<List<User>> {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;
  SuggestionsNotifier(this._authUseCase, this._userUseCase) : super([]);

  Future<void> getSuggestions() async {
    final auth = await _authUseCase.getLocalAuth();
    state = await _userUseCase.getFollowersSuggestions(auth!);
  }
}
