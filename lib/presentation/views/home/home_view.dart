import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/config/config.dart';
import 'package:instagram/presentation/providers/providers.dart';

import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(profileProvider.notifier).getMainProfile();
  }

  bool _isLoading = false;

  Future<void> _handleRefresh() async {
    // Simula una operación de recarga (reemplaza esto con tu lógica real)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.titleLarge?.color;
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomAppBar(
              leading: Image.asset(AssetsConsts.instagramLogo, color: color),
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
                  _ListViewStories(),
                  const FeedReel(),
                  //const FeedPost()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListViewStories extends StatelessWidget {
  const _ListViewStories();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < 10; i++)
            (i == 0)
                ? const AvatarAddMedia()
                : const AvatarFetchMedia(username: 'username'),
        ],
      ),
    );
  }
}
