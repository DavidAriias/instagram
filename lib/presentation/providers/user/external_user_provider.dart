import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/domain/entities/entities.dart';

final externalUserProvider =
    StateNotifierProvider<ExternalUserNotifier, User>((ref) {
  return ExternalUserNotifier(userUseCase, authUseCase);
});

class ExternalUserNotifier extends StateNotifier<User> {
  final UserUseCase _userUseCase;
  final AuthUseCase _authUseCase;

  ExternalUserNotifier(this._userUseCase, this._authUseCase) : super(User());

  Future<User> getDetailsExternalProfile(String userId) async {
    final auth = await _authUseCase.getLocalAuth();
    auth?.userId = userId;
    final user = await _userUseCase.getUserDetails(auth!);
    state = user;
    return user;
  }
}
