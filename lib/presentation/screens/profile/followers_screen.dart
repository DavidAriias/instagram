import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/entities.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FollowersScreen extends StatelessWidget {
  static const String name = 'followers-screen';

  const FollowersScreen({super.key, required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _FollowersView(page: page),
    );
  }
}

class _FollowersView extends ConsumerStatefulWidget {
  const _FollowersView({required this.page});

  final String page;

  @override
  FollowersViewState createState() => FollowersViewState();
}

class FollowersViewState extends ConsumerState<_FollowersView> {
  @override
  void initState() {
    super.initState();
    //TODO: REFACTORIZAR LOS PROVIDERS EN UNO SOLO EN EL FOLLOWERS
    ref.read(followersProvider.notifier).getFollowers();
    ref.read(followingProvider.notifier).getFollowing();
    ref.read(suggestionsProvider.notifier).getSuggestions();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final textStyle = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color;

    final profile = ref.watch(mainUserProvider);
    final followers = ref.watch(followersProvider);
    final following = ref.watch(followingProvider);
    final suggestions = ref.watch(suggestionsProvider);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          centerTitle: true,
          title: Text(profile.username,
              style:
                  textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          leadingWidth: 56,
          padding: const EdgeInsets.all(0),
          leading: CustomIconCupertinoButton(
              onPressed: () => context.pop(),
              child: Icon(Icons.arrow_back_ios_new, color: iconColor)),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: height,
            child: GridPageView(
                initialPage: int.tryParse(widget.page) ?? 0,
                navbarIcons: [
                  Text('${profile.followersCount} followers'),
                  Text('${profile.followingCount} following'),
                  const Text('For you')
                ],
                selectedColor: Colors.white,
                childrenGrid: [
                  _FollowersList(
                    itemCount: profile.followersCount,
                    users: followers.isEmpty ? [] : followers,
                  ),
                  _FollowersList(
                    itemCount: profile.followingCount,
                    users: following.isEmpty ? [] : following,
                  ),
                  _FollowersList(
                    itemCount: suggestions.length,
                    users: suggestions.isEmpty ? [] : suggestions,
                  )
                ]),
          ),
        )
      ],
    );
  }
}

class _FollowersList extends StatelessWidget {
  const _FollowersList({
    this.itemCount,
    required this.users,
  });

  final int? itemCount;
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              leading: (users.isEmpty)
                  ? const ShimmerEffect(borderRadius: 30, child: CircleAvatar(radius: 30))
                  : UserAvatarWithoutGradient(
                      radius: 30, image: users[index].profilePictureUrl),
              title: (users.isEmpty)
                  ? const ShimmerEffect(
                      height: 10, borderRadius: 10)
                  : Text(users[index].username),
              trailing: (users.isEmpty)
                  ? const SizedBox.shrink()
                  : CustomButton(
                      width: 100,
                      height: 35,
                      textButton: 'Follow',
                      onPressed: () {}),
            ));
  }
}
