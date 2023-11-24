import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class InstagramSwiper extends StatefulWidget {
  const InstagramSwiper(
      {super.key, required this.mediaUrls, required this.mediaHeight});

  final List<String> mediaUrls;
  final double mediaHeight;

  @override
  State<InstagramSwiper> createState() => _InstagramSwiperState();
}

class _InstagramSwiperState extends State<InstagramSwiper> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  bool showCounter = false;
  bool isLiked = false;
  bool isLikedAnimation = false;
  double heartPositionX = 0;
  double heartPositionY = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!.round();
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
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: widget.mediaHeight,
          child: Stack(
            children: [
              PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    showCounter = true;
                  });
                },
                controller: _pageController,
                itemCount: widget.mediaUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onDoubleTapDown: (TapDownDetails details) {
                        setState(() {
                          heartPositionX = details.globalPosition.dx;
                          heartPositionY = details.globalPosition.dy;
                          isLiked = true;
                          isLikedAnimation = true;
                        });

                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            isLikedAnimation = false;
                          });
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.mediaUrls[index],
                        imageBuilder: (context, imageProvider) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      ));
                },
              ),
              ImageCounter(
                  top: 10,
                  right: 10,
                  showCounter: showCounter,
                  currentIndex: currentIndex,
                  imagesLength: widget.mediaUrls.length),
              LikeAnimation(
                  isLiked: isLikedAnimation,
                  heartPositionX: heartPositionX,
                  heartPositionY: heartPositionY)
            ],
          ),
        ),
        ButtonsUnderMedia(
            optionalWidget: _Slider(
                size: size,
                pageController: _pageController,
                posts: widget.mediaUrls,
                currentIndex: currentIndex))
      ],
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    required this.size,
    required PageController pageController,
    required this.posts,
    required this.currentIndex,
  }) : _pageController = pageController;

  final Size size;
  final PageController _pageController;
  final List<String> posts;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: size.width / 4.5),
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            return _ImageProgressIndicator(
                posts: posts, currentIndex: currentIndex);
          },
        ));
  }
}

class _ImageProgressIndicator extends StatelessWidget {
  const _ImageProgressIndicator({
    required this.posts,
    required this.currentIndex,
  });

  final List<String> posts;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: posts.asMap().entries.map((entry) {
        double size = currentIndex == entry.key ? 8.0 : 5.0;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: size,
          height: size,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == entry.key ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}
