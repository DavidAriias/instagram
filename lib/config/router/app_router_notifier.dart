import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/presentation/enums/enums.dart';
import 'package:instagram/presentation/providers/providers.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  final registerNotifier = ref.read(registerFormProvider.notifier);
  return GoRouterNotifier(authNotifier, registerNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  final RegisterFormNotifier _registerFormNotifier;

  AuthStatus _authStatus = AuthStatus.checking;
  RegisterStatus _registerStatus = RegisterStatus.defaultStatus;

  GoRouterNotifier(this._authNotifier, this._registerFormNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.status;
    });
    _registerFormNotifier.addListener((state) {
      registerStatus = state.registerStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  RegisterStatus get registerStatus => _registerStatus;

  set registerStatus(RegisterStatus value) {
    _registerStatus = value;
    notifyListeners();
  }
}
