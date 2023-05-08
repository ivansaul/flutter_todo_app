import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:todo_app/config/provider/providers.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(todoStatusFilterProvider);
    return StylishBottomBar(
      items: [
        BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('All')),
        BottomBarItem(
            icon: const Icon(Icons.star_border_rounded),
            selectedIcon: const Icon(Icons.star_rounded),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Completed')),
        BottomBarItem(
            icon: const Icon(
              Icons.style_outlined,
            ),
            selectedIcon: const Icon(
              Icons.style,
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Pending')),
        BottomBarItem(
            icon: const Icon(
              Icons.access_time_outlined,
            ),
            selectedIcon: const Icon(
              Icons.access_time_filled_outlined,
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Reminders')),
      ],
      hasNotch: true,
      fabLocation: StylishBarFabLocation.center,
      currentIndex: currentIndex,
      onTap: (index) {
        ref.read(todoStatusFilterProvider.notifier).update((state) => index);
      },
      option: AnimatedBarOptions(
        // iconSize: 32,
        barAnimation: BarAnimation.fade,
        iconStyle: IconStyle.Default,
        // opacity: 0.3,
      ),
    );
  }
}
