import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class EditScreen extends StatelessWidget {
  static const String name = 'edit-screen';
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _EditView(),
    );
  }
}

class _EditView extends ConsumerWidget {
  const _EditView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = Theme.of(context).iconTheme.color;
    final textStyle = Theme.of(context).textTheme;
    final dividerColor = Colors.grey.shade300.withOpacity(0.3);

    final profile = ref.watch(mainUserProvider);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          centerTitle: true,
          title: Text('Edit profile',
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
          child: Column(
            children: [
              UserAvatarWithoutGradient(
                  image: profile.profilePictureUrl, radius: 40),
             EditPictureProfilePopUpSurface(
              image: profile.profilePictureUrl,
              dividerColor: dividerColor,
             ),
              Divider(color: dividerColor),
              _RowData(
                prefixText: 'Name',
                text: profile.name,
                placeholder: 'Add name',
                onTap: () => context.push('/profile/edit/field/name')
              ),
              Divider(color: dividerColor),
              _RowData(
                  prefixText: 'Username',
                  placeholder: 'Add Username',
                  text: profile.username,
                  onTap: () =>  context.push('/profile/edit/field/username'),
              ),
              Divider(color: dividerColor),
              _RowData(
                prefixText: 'Pronouns',
                placeholder: 'Add Pronouns',
                text: profile.pronoun,
                onTap: () => context.push('/profile/edit/field/pronouns'),
              ),
              Divider(color: dividerColor),
              _RowData(
                text: profile.bio,
                prefixText: 'Bio',
                placeholder: 'Add bio',
                onTap: () => context.push('/profile/edit/field/bio'),
              ),
              Divider(color: dividerColor),
              _RowData(
                text: '', //TODO : CAMBIAR
                prefixText: 'Link',
                placeholder: 'Add link',
                onTap: () => context.push('/profile/edit/field/link'),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    required this.prefixText,
    this.placeholder,
    required this.text,
    this.onTap,
  });

  final String prefixText;
  final String? placeholder;
  final String? text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundDeviceColor = Theme.of(context).colorScheme.background;
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: CupertinoTextField(
        onTap: onTap,
        decoration: BoxDecoration(
          color: backgroundDeviceColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        readOnly: true,
        placeholder: text ?? placeholder,
        placeholderStyle: (text != null)
            ? textStyle.titleMedium
            : textStyle.titleMedium?.copyWith(color: Colors.grey),
        prefix: Text(prefixText, style: textStyle.titleMedium),
      ),
    );
  }
}
