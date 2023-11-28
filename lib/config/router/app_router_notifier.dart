import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/presentation/enums/enums.dart';
import 'package:instagram/presentation/providers/providers.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  final registerNotifier = ref.read(registerFormProvider.notifier);
  final postNotifier = ref.read(postProvider.notifier);
  return GoRouterNotifier(authNotifier, registerNotifier, postNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  final RegisterFormNotifier _registerFormNotifier;
  final PostNotifier _postNotifier;

  AuthStatus _authStatus = AuthStatus.checking;
  RegisterStatus _registerStatus = RegisterStatus.defaultStatus;
  PostStatus _postStatus = PostStatus.editing;

  GoRouterNotifier(
      this._authNotifier, this._registerFormNotifier, this._postNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.status;
    });
    _registerFormNotifier.addListener((state) {
      registerStatus = state.registerStatus;
    });

    _postNotifier.addListener((state) {
      postStatus = state.status;
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

  PostStatus get postStatus => _postStatus;

  set postStatus(PostStatus value) {
    _postStatus = value;
    notifyListeners();
  }
}
