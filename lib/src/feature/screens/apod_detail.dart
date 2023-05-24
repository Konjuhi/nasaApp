import 'package:cached_network_image/cached_network_image.dart';
import 'package:expunivers/src/feature/models/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/state_manager.dart';

class ApodDetail extends StatefulWidget {
  final List<Photos> photos;
  final int initialIndex;

  const ApodDetail({
    Key? key,
    required this.photos,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _ApodDetailState createState() => _ApodDetailState();
}

class _ApodDetailState extends State<ApodDetail> {
  late PageController _pageController;
  late int _currentIndex;
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.photos.length - 1) {
      setState(() {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final sliderScalar = ref.watch(sliderScalarProvider);
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(widget.photos[_currentIndex].id.toString()),
                pinned: true,
                floating: false,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: InteractiveViewer(
                        transformationController: _transformationController,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.photos.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: widget.photos[index].imgSrc ?? '',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            );
                          },
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      min: 1.0,
                      max: 4.0,
                      divisions: 20,
                      label: sliderScalar.toStringAsPrecision(2),
                      value: sliderScalar,
                      onChanged: (newValue) {
                        ref.read(sliderScalarProvider.notifier).state =
                            newValue;
                        _transformationController.value =
                            Matrix4.identity().scaled(newValue);
                      },
                      activeColor: Colors.purple[200],
                      inactiveColor: Colors.purple[800],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: _goToPrevious,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: _goToNext,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
