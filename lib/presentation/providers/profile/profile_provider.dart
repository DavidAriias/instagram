import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/domain/entities/user.dart';
import 'package:instagram/presentation/providers/providers.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, User>((ref) {
  final mainProfileCallback =
      ref.watch(mainUserProvider.notifier).getDetailsMainProfile;
  final externalProfileCallback =
      ref.watch(externalUserProvider.notifier).getDetailsExternalProfile;
  return ProfileNotifier(mainProfileCallback, externalProfileCallback);
});

class ProfileNotifier extends StateNotifier<User> {
  Future<User> Function() mainProfileCallback;
  Future<User> Function(String) externalProfileCallback;
  ProfileNotifier(this.mainProfileCallback, this.externalProfileCallback)
      : super(User());

  Future<void> getMainProfile() async {
    state = await mainProfileCallback();
  }

  Future<void> getExternalProfile(String userId) async {
    state = await externalProfileCallback(userId);
  }
}
