import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musica_music_player/constants/color_constants.dart';

class NullArtworkWidget extends StatelessWidget {
  const NullArtworkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double artworkSize = 44;
    return Container(
      width: artworkSize,
      height: artworkSize,
      color: secondaryColor500,
      child: const Icon(
        Icons.album_outlined,
        color: primaryColor500,
        size: 44,
      ),
    );
  }
}
