import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musica_music_player/constants/color_constants.dart';

class NullArtworkWidget extends StatelessWidget {
  final double artworkSize;
  const NullArtworkWidget({
    Key? key,
    required this.artworkSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: secondaryColor500,
      child: Icon(
        Icons.album_outlined,
        color: primaryColor500,
        size: artworkSize,
      ),
    );
  }
}
