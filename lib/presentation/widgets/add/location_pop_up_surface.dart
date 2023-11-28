import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class LocationPopUpSurface extends ConsumerWidget {
  const LocationPopUpSurface({super.key, this.onSongSelected});

  final FutureOr<void> Function()? onSongSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;

    final textStyle = Theme.of(context).textTheme;

    final controller = TextEditingController();
    final dividerColor = Colors.grey.shade300.withOpacity(0.3);

    return CustomIconCupertinoButton(
        onPressed: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => Consumer(
                builder: (context, ref, child) {
                  final locations = ref.watch(listLocationProvider);
                  return CustomCupertinoPopUpSurface(
                    onVerticalDragUpdate: (_) {
                      context.pop();
                      controller.clear();
                    },
                    // TODO: CHECAR LA NAVEGACION
                    height: deviceHeight / 1.1,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CupertinoSearchTextField(
                                controller: controller,
                                style: textStyle.titleSmall,
                                autofocus: true,
                                onChanged: ref
                                    .read(listLocationProvider.notifier)
                                    .getLocationByName,
                                onSuffixTap: () {
                                  controller.clear();
                                }),
                          ),
                          CustomTextButton(
                            textButton: 'Cancel',
                            onPressed: () {
                              controller.clear();
                              context.pop();
                            },
                          )
                        ],
                      ),
                      Flexible(
                        child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                Divider(color: dividerColor),
                            physics: const BouncingScrollPhysics(),
                            itemCount: locations.length,
                            itemBuilder: (context, index) {
                              final currentLocation = locations[index];
                              return CupertinoListTile(
                                onTap: () {
                                  ref
                                      .read(postProvider.notifier)
                                      .onChangeLocation(currentLocation);
                                },
                                title: Text(currentLocation.name,
                                    style: textStyle.bodyLarge),
                                subtitle: Text(
                                  style: textStyle.bodyMedium
                                      ?.copyWith(color: Colors.grey),
                                  '${currentLocation.city}${currentLocation.city.isNotEmpty ? ',' : ''}'
                                  '${currentLocation.state}${currentLocation.state.isNotEmpty ? ',' : ''}'
                                  '${currentLocation.country}',
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                },
              ),
            ),
        child: const Icon(CupertinoIcons.chevron_forward, color: Colors.grey));
  }
}
