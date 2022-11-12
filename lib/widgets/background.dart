import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constanta.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({
    super.key,
    required this.imageUrl,
    required this.child,
  });
  final String imageUrl;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.multiply,
            color: black.withOpacity(.1),
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              color: black,
            ),
            errorWidget: (context, url, error) => const Center(
                child:
                    SizedBox(height: 40, width: 40, child: Icon(Icons.error))),
          ),
        ),
        Positioned.fill(
          child: Center(
              child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              color: black.withOpacity(.5),
            ),
          )),
        ),
        child
      ],
    );
  }
}
