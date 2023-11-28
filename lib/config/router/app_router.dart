import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:instagram/config/router/app_router_notifier.dart';
import 'package:instagram/presentation/enums/enums.dart';
import 'package:instagram/presentation/screens/shared/change_password_screen.dart';

import '../../presentation/screens/screens.dart';
import '../../presentation/views/views.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        name: CheckAuthStatusScreen.name,
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
          path: '/register',
          name: SignUpScreen.name,
          builder: (context, state) => const SignUpScreen(),
          routes: [
            GoRoute(
              path: 'confirmAccount',
              name: ConfirmAccountScreen.name,
              builder: (context, state) => const ConfirmAccountScreen(),
            )
          ]),
      GoRoute(
          path: '/pass',
          name: ChangePasswordScreen.forgetPasswordName,
          builder: (context, state) => const ChangePasswordScreen()),
      ShellRoute(
          builder: (context, state, child) => HomeScreen(childView: child),
          routes: [
            GoRoute(
              path: '/',
              name: HomeScreen.name,
              builder: (context, state) => const HomeView(),
            ),
            GoRoute(
              path: '/search',
              name: SearchScreen.name,
              builder: (context, state) => const SearchScreen(),
            ),
            ShellRoute(
                builder: (context, state, child) => AddScreen(childView: child),
                routes: [
                  GoRoute(
                    path: '/add',
                    name: AddScreen.name,
                    builder: (context, state) => const AddView(),
                  ),
                  GoRoute(
                      path: '/reel',
                      name: CreateReelScreen.name,
                      builder: (context, state) => const CreateReelScreen()),
                  GoRoute(
                      path: '/story',
                      name: CreateStoryScreen.name,
                      builder: (context, state) => const CreateStoryScreen())
                ]),
            GoRoute(
                path: '/share',
                name: SharePostScreen.name,
                builder: (context, state) => const SharePostScreen()),
            GoRoute(
              path: '/reels',
              name: ReelScreen.name,
              builder: (context, state) => const ReelScreen(),
            ),
            GoRoute(
                path: '/profile',
                name: ProfileScreen.name,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                      path: 'followers/:page',
                      name: FollowersScreen.name,
                      builder: (context, state) {
                        final page = state.pathParameters['page'];
                        return FollowersScreen(page: page!);
                      }),
                  GoRoute(
                      path: 'post/:id',
                      name: PostScreen.name,
                      builder: (context, state) {
                        final postId = state.pathParameters['id'];
                        return PostScreen(postId: postId!);
                      }),
                  GoRoute(
                      path: 'edit',
                      name: EditScreen.name,
                      builder: (context, state) => const EditScreen(),
                      routes: [
                        GoRoute(
                            path: 'field/:name',
                            name: EditFieldScreen.name,
                            builder: (context, state) {
                              final fieldName = state.pathParameters['name'];
                              return EditFieldScreen(fieldName: fieldName!);
                            })
                      ]),
                  GoRoute(
                      path: 'verified',
                      name: MetaVerifiedScreen.name,
                      builder: (context, state) => const MetaVerifiedScreen()),
                  GoRoute(
                      path: 'password',
                      name: ChangePasswordScreen.name,
                      builder: (context, state) => const ChangePasswordScreen())
                ]),
          ]),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      final registerStatus = goRouterNotifier.registerStatus;
    //final postStatus = goRouterNotifier.postStatus;


      if (registerStatus == RegisterStatus.validating) return '/login';

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/pass') return null;
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash' ||
            isGoingTo == '/pass') {
          return '/';
        }
      }

      return null;
    },
  );
});
