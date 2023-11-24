import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/domain/entities/entities.dart';

final mainUserProvider = StateNotifierProvider<MainUserNotifier, User>((ref) {
  return MainUserNotifier(userUseCase, authUseCase);
});

class MainUserNotifier extends StateNotifier<User> {
  final UserUseCase _userUseCase;
  final AuthUseCase _authUseCase;
  MainUserNotifier(this._userUseCase, this._authUseCase) : super(User());

  Future<User> getDetailsMainProfile() async {
    //TODO : REFACTORIZAR EL AUTH PONIENDO EN LUGAR DE LA LLAMADA AL GET LOCAL AUTH COMO CALLBACK
    final auth = await _authUseCase.getLocalAuth();
    final user = await _userUseCase.getUserDetails(auth!);
    state = user;
    return user;
  }

  Future<String> updatePassword(String password) async {
    final auth = await _authUseCase.getLocalAuth();
    return await _userUseCase.updatePassword(auth!, password);
  }

  Future<String> updateVerified() async {
    final auth = await _authUseCase.getLocalAuth();
    return await _userUseCase.updateVerified(auth!);
  }

}
