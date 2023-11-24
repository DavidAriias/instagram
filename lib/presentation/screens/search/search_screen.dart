import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/domain/entities/user.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class SearchScreen extends ConsumerWidget {
  static const String name = 'search-screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    final result = ref.watch(searchProvider);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomAppBar(
              leading: CupertinoSearchTextField(
                onChanged:
                    ref.read(searchProvider.notifier).getSearchUsersRemote,
                style: textStyle.labelLarge,
              ),
              leadingWidth: double.infinity,
              padding: const EdgeInsets.all(0),
              toolbarHeight: 40,
              pinned: true,
            ),
            //_RecentRow(textStyle: textStyle),
            _SearchList(result: result, itemCount: result.length)
            //_RecentList(users: result)
          ],
        ),
      ),
    ));
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow({
    required this.textStyle,
  });

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text('Recent', style: textStyle.titleMedium),
          const Spacer(),
          CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: Text('See all',
                  style: textStyle.titleMedium?.copyWith(color: Colors.blue)),
              onPressed: () {})
        ],
      ),
    );
  }
}

class _SearchList extends ConsumerWidget {
  const _SearchList({
    required this.result,
    this.itemCount,
  });

  final List<User> result;
  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                final externalUserId = result[index].id;
                ref
                    .read(profileProvider.notifier)
                    .getExternalProfile(externalUserId);
                
                context.push('/profile');
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              leading: (result.isEmpty)
                  ? const ShimmerEffect(
                      width: 30,
                      height: 30,
                      borderRadius: 30,
                    )
                  : UserAvatarWithoutGradient(
                      radius: 30, image: result[index].profilePictureUrl),
              title: (result.isEmpty)
                  ? const ShimmerEffect(height: 10, borderRadius: 10)
                  : Text(result[index].username),
              subtitle: (result.isEmpty)
                  ? const ShimmerEffect(height: 10, borderRadius: 10)
                  : Text(result[index].name ?? ''),
            ));
  }
}

class _RecentList extends StatelessWidget {
  const _RecentList({
    required this.users,
  });

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              leading: UserAvatarWithoutGradient(
                  radius: 30, image: users[index].profilePictureUrl),
              title: Text(users[index].username),
              subtitle: Text(users[index].name ?? ''),
              trailing: const Icon(Icons.close, color: Colors.grey, size: 20),
            ));
  }
}
