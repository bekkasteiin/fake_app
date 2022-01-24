import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kinfolk/kinfolk.dart';

import 'loader_widget.dart';

class CachedImage extends StatelessWidget {
  final String fileDescriptorId;
  const CachedImage(this.fileDescriptorId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: Kinfolk.getFileUrl(fileDescriptorId),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, string) => const Center(
        child: LoaderWidget(),
      ),
      errorWidget: (context, url, error) => Container(
        child: const Center(
          child: Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
            size: 25,
          ),
        ),
      ),
    );
  }
}