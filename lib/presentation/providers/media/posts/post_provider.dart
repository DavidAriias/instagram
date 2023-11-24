import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/auth/auth_usecase.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/domain/entities/entities.dart';


final postProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier(postUseCase, authUseCase);
});

class PostNotifier extends StateNotifier<List<Post>> {
  final PostUseCase _postUseCase;
  final AuthUseCase _authUseCase;
  PostNotifier(this._postUseCase, this._authUseCase) : super([]);

  Future<void> fetchPostsFromUser() async {
    final auth = await _authUseCase.getLocalAuth();    
    state = await _postUseCase.fetchPostFromUser(auth!);
  }
}
