import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/domain/entities/entities.dart';

import '../../../config/dependenciesInjection/instances_container.dart';


final followersProvider = StateNotifierProvider<FollowersNotifier, List<User>>((ref) {
   return FollowersNotifier(authUseCase, userUseCase);
});

class FollowersNotifier extends StateNotifier<List<User>> {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;
  FollowersNotifier(this._authUseCase, this._userUseCase) : super([]);

  Future<void> getFollowers() async {
    final auth = await _authUseCase.getLocalAuth();
    state = await _userUseCase.getFollowers(auth!);
  }

  Future<void> getFollowing() async {
    final auth = await _authUseCase.getLocalAuth();
    state = await _userUseCase.getFollowing(auth!);
  }

  Future<void> getSuggestions() async {
    final auth = await _authUseCase.getLocalAuth();
    state = await _userUseCase.getFollowersSuggestions(auth!);
  }
}
