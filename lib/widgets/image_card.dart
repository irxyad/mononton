import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Image.network(
        'https://image.tmdb.org/t/p/original$image',
        filterQuality: FilterQuality.medium,
        isAntiAlias: false,
        fit: BoxFit.cover,
      ),
    );
  }
}
