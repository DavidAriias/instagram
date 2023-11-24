import 'package:flutter/material.dart';

class GridPageView extends StatefulWidget {
  const GridPageView(
      {super.key,
      required this.navbarIcons,
      required this.selectedColor,
      required this.childrenGrid,
      this.initialPage = 0})
      : assert(navbarIcons.length == childrenGrid.length,
            'navbarIcons and childrenGrid must be the same length'),
            assert(!(initialPage > childrenGrid.length), 'initial page must be minor than childrenGrid length');

  final List<Widget> navbarIcons;
  final Color? selectedColor;
  final List<Widget> childrenGrid;
  final int initialPage;

  @override
  State<GridPageView> createState() => _GridPageViewState();
}

class _GridPageViewState extends State<GridPageView> {
  late PageController _pageController;
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _currentPageIndex = widget.initialPage;

    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NavBar(
          selectedColor: widget.selectedColor,
          pageController: _pageController,
          icons: widget.navbarIcons,
          currentPageIndex: _currentPageIndex,
          pages: widget.navbarIcons.length,
        ),
        Flexible(
            child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.navbarIcons.length,
                itemBuilder: (context, index) => widget.childrenGrid[index])),
      ],
    );
  }
}

class _NavBar extends StatelessWidget {
  final PageController pageController;
  final List<Widget> icons;
  final int currentPageIndex;
  final int pages;
  final Color? selectedColor;

  const _NavBar(
      {required this.pageController,
      required this.icons,
      required this.currentPageIndex,
      required this.pages,
      required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < icons.length; i++)
          _NavBarIcon(
            icon: icons[i],
            pageIndex: i,
            pageController: pageController,
            isSelected: i == currentPageIndex,
            pages: pages,
            selectedColor: selectedColor,
          ),
      ],
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final Widget icon;
  final int pageIndex;
  final PageController pageController;
  final bool isSelected;
  final int pages;
  final Color? selectedColor;

  const _NavBarIcon(
      {required this.icon,
      required this.pageIndex,
      required this.pageController,
      required this.isSelected,
      required this.pages,
      required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        pageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        children: [
          icon,
          const SizedBox(height: 10),
          Container(
            width: width / pages,
            height: 1.5,
            color: isSelected ? selectedColor : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
