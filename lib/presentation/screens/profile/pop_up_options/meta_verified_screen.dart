import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class MetaVerifiedScreen extends StatelessWidget {
  static const String name = 'meta-verified-screen';
  const MetaVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MetaVerifiedView(),
    );
  }
}

class _MetaVerifiedView extends ConsumerWidget {
  const _MetaVerifiedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = Theme.of(context).iconTheme.color;

    final textStyle = Theme.of(context).textTheme;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          leading: CustomIconCupertinoButton(
              onPressed: () => context.pop(),
              child: Icon(Icons.close, color: iconColor)),
          leadingWidth: 56,
          padding: const EdgeInsets.all(0),
          pinned: true,
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Join to Meta Verified',
                style: textStyle.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Text(
                        'Establish your presence and get access to exclusive benefits with Meta Verified.')),
                Flexible(
                    child: CustomLinkButton(
                        link:
                            'https://about.meta.com/technologies/meta-verified',
                        label: 'Learn more'))
              ],
            ),
            const SizedBox(height: 20),
            const _PointRow(
              title: 'A verified badge',
              subtitle:
                  "Your audience can trust that you're a real person sharing you real stories",
              icon: Icons.verified_outlined,
            ),
            const SizedBox(height: 20),
            const _PointRow(
              title: 'Increased account protection',
              subtitle:
                  "Worry less about impersonation with proactive identify monitoring",
              icon: Icons.shield_outlined,
            ),
            const SizedBox(height: 20),
            const _PointRow(
              title: 'Support when you need it',
              subtitle:
                  "Get answers more quickly about the things that matter to you. Right now, support is only available in some languages",
              icon: Icons.people_outline,
            ),
            const SizedBox(height: 20),
            const _PointRow(
              title: 'Unique stickers',
              subtitle:
                  "Express yourself with stickers only available to Meta Verified subscribers",
              icon: Icons.sticky_note_2_outlined,
            ),
            const SizedBox(height: 40),
            CustomButton(
                textButton: 'Join',
                onPressed: () => ref.read(mainUserProvider.notifier).updateVerified())
          ]),
        ))
      ],
    );
  }
}

class _PointRow extends StatelessWidget {
  const _PointRow({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color;
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textStyle.titleMedium),
              Text(subtitle)
            ],
          ),
        )
      ],
    );
  }
}
