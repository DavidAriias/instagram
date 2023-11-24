import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/config/config.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'profile-screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _ProfileView());
  }
}

class _ProfileView extends ConsumerStatefulWidget {
  const _ProfileView();

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<_ProfileView> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> _handleRefresh() async {
    // Simula una operación de recarga (reemplaza esto con tu lógica real)
    await Future.delayed(const Duration(seconds: 2));
    //TODO: POENR LAS SUBSCRIPTIONS

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(postProvider.notifier).fetchPostsFromUser();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

    final height = MediaQuery.of(context).size.height;
    final profile = ref.watch(profileProvider);

    final posts = ref.watch(postProvider);
    final mainUserId = ref.watch(mainUserProvider).id;

    return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SafeArea(
            child: CustomScrollView(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            (mainUserId != profile.id)
                ? AppBarExternalProfile(
                    username: profile.username, iconColor: iconColor,
                    isVerified: profile.isVerificated,
                  )
                : AppBarMainProfile(
                    username: profile.username, iconColor: iconColor,
                    isVerified: profile.isVerificated,
                  ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (_isLoading) ...[
                    const CircularProgressIndicator
                        .adaptive(), // Indicador de carga
                    const SizedBox(
                        height:
                            16), // Espacio entre el indicador de carga y la lista de historias
                  ],
                  _FirstPartProfile(scrollController: _scrollController),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: height / 1.5,
                    child: GridPageView(
                      navbarIcons: [
                        Icon(Icons.grid_on, color: iconColor),
                        Image.asset(AssetsConsts.reelIcon,
                            width: 28, height: 28, color: iconColor),
                        Icon(Icons.portrait, color: iconColor)
                      ],
                      childrenGrid: [
                        MediaGridPage(
                          childAspectRatio: 1.1,
                          urls: posts.isEmpty
                              ? []
                              : posts
                                  .map((post) => post.mediaUrls.first)
                                  .toList(),
                          icon: const Icon(Icons.photo_library,
                              color: Colors.white),
                          titleForNonContent: 'No posts yet',
                          subtitleForNonContent:
                              "When you upload posts, they'll appear here.",
                          pagePath: '/post/',
                          mediaIds: posts.map((post) => post.id).toList(),
                        ),
                        MediaGridPage(
                          childAspectRatio: 1.1,
                          urls: [],
                          icon: Image.asset(AssetsConsts.reelBoldIcon,
                              width: 25, height: 25, color: Colors.white),
                          titleForNonContent: 'Reels',
                          subtitleForNonContent:
                              "Reels are short videos on Instagram. When you share a reel, they'll appear here.",
                        ),
                        const MediaGridPage(
                          childAspectRatio: 1.1,
                          urls: [],
                          icon: Icon(Icons.portrait, color: Colors.white),
                          titleForNonContent: 'Photos and videos of you',
                          subtitleForNonContent:
                              "When people tag you in photos and videos, they'll appear here.",
                        )
                      ],
                      selectedColor: iconColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}

class _FirstPartProfile extends ConsumerWidget {
  const _FirstPartProfile({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final profile = ref.watch(profileProvider);
    final mainUserId = ref.watch(mainUserProvider).id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AvatarAndStadistics(
            avatarRadius: 40,
            image: profile.profilePictureUrl,
            titleStyle: textStyle.titleMedium,
            subtitleStyle: textStyle.bodyMedium,
            followers: profile.followersCount,
            following: profile.followingCount,
            postsNumber: profile.postCount,
            scrollController: scrollController,
          ),
          const SizedBox(height: 10),
          _CustomText(text: profile.name, textStyle: textStyle.titleMedium),
          _CustomText(text: profile.bio, textStyle: textStyle.bodyMedium),
          CustomLinkButton(
            link: 'https://rembeauty.com',
             label: 'rembeauty.com'),
          (mainUserId != profile.id) ? CustomButton(
            textButton: 'Follow', 
            width: double.infinity,
            height: 30,
            
            onPressed: () {}) :
            CustomButtonRectanguleGrey(
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            onPressed: () => context.push('/profile/edit'),
            child: const Text('Edit profile',
                style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    required this.text,
    required this.textStyle,
  });

  final String? text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return (text != null)
        ? Text(text!, style: textStyle)
        : const SizedBox.shrink();
  }
}

class _AvatarAndStadistics extends StatelessWidget {
  const _AvatarAndStadistics(
      {this.avatarRadius,
      this.titleStyle,
      this.subtitleStyle,
      required this.postsNumber,
      required this.followers,
      required this.following,
      this.image,
      required this.scrollController});

  final double? avatarRadius;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final int postsNumber;
  final int followers;
  final int following;
  final String? image;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatarWithoutGradient(radius: avatarRadius, image: image),
        const Spacer(),
        _StadisticsRow(
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
          followers: followers,
          following: following,
          postsNumber: postsNumber,
          scrollController: scrollController,
        ),
      ],
    );
  }
}

class _StadisticsRow extends StatelessWidget {
  const _StadisticsRow(
      {this.titleStyle,
      this.subtitleStyle,
      required this.postsNumber,
      required this.followers,
      required this.following,
      required this.scrollController});

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final int postsNumber;
  final int followers;
  final int following;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final targetPosition = MediaQuery.of(context).size.height / 2;
    return Row(
      children: [
        _StadisticColumn(
          title: HumanFormatHelper.humanReadbleNumber(postsNumber),
          subtitle: 'Posts',
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          onTap: () {
            scrollController.animateTo(
              targetPosition,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        const SizedBox(width: 30),
        _StadisticColumn(
          title: HumanFormatHelper.humanReadbleNumber(followers),
          subtitle: 'Followers',
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          onTap: () => context.push('/profile/followers/0'),
        ),
        const SizedBox(width: 30),
        _StadisticColumn(
          title: HumanFormatHelper.humanReadbleNumber(following),
          subtitle: 'Following',
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          onTap: () => context.push('/profile/followers/1'),
        )
      ],
    );
  }
}

class _StadisticColumn extends StatelessWidget {
  const _StadisticColumn({
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(title, style: titleStyle),
          Text(subtitle, style: subtitleStyle),
        ],
      ),
    );
  }
}
