import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

import '../../../config/config.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case '/':
        return 0;
      case '/search':
        return 1;
      case '/add':
        return 2;
      case '/reels':
        return 3;
      case '/profile':
        return 4;
      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index, WidgetRef ref) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/add');
        break;
      case 3:
        context.go('/reels');
        break;
      case 4:
       ref.read(profileProvider.notifier).getMainProfile();
        context.go('/profile');
        break;
      default:
        context.go('/');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).iconTheme.color;
    final image = ref.watch(mainUserProvider).profilePictureUrl;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: CupertinoTabBar(
        currentIndex: getCurrentIndex(context),
        onTap: (index) => onItemTapped(context, index, ref),
        activeColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: color),
              activeIcon: Icon(Icons.home, color: color)),
          BottomNavigationBarItem(
            icon: Image.asset(AssetsConsts.searchIcon,
                width: 22, height: 22, color: color),
            activeIcon: Icon(Icons.search, color: color, size: 32),
          ),
          BottomNavigationBarItem(
              icon: Image.asset(AssetsConsts.addIcon,
                  width: 25, height: 25, color: color),
              activeIcon: Image.asset(AssetsConsts.addBoldIcon,
                  width: 24, height: 24, color: color)),
          BottomNavigationBarItem(
              icon: Image.asset(AssetsConsts.reelIcon,
                  width: 28, height: 28, color: color),
              activeIcon: Image.asset(AssetsConsts.reelBoldIcon,
                  width: 28, height: 28, color: color)),
          BottomNavigationBarItem(
            icon: UserAvatarWithoutGradient(
              radius: 15,
              image: image,
            ),
          ),
        ],
      ),
    );
  }
}
