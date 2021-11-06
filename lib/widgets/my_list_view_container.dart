import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musica_music_player/constants/color_constants.dart';
import 'package:musica_music_player/screen/song_screen.dart';
import 'package:musica_music_player/widgets/null_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'my_text.dart';

class MyListViewContainer extends StatefulWidget {
  final String title;
  final String artist;
  final QueryArtworkWidget artwork;
  final String uri;

  const MyListViewContainer({
    Key? key,
    required this.title,
    required this.artist,
    required this.artwork,
    required this.uri,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _MyListViewContainer(
        title: title,
        artist: artist,
        artwork: artwork,
        uri: uri,
      );
}

class _MyListViewContainer extends State<MyListViewContainer> {
  final String title;
  final String artist;
  final QueryArtworkWidget artwork;
  final String uri;

  _MyListViewContainer({
    required this.title,
    required this.artist,
    required this.artwork,
    required this.uri,
  });

  _playSong() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SongScreen(
                  artist: artist,
                  source: uri,
                  title: title,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: _playSong,
            child:
                Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: QueryArtworkWidget(
                  id: artwork.id,
                  type: artwork.type,
                  nullArtworkWidget: const NullArtworkWidget(artworkSize: 50,),
                  artworkFit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 220,
                        child: MyText(
                          title,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 220,
                        child: MyText(
                          artist,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor300,
                        ),
                      ),
                    ]),
              ),
            ]),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shape: const CircleBorder(),
              elevation: 0,
            ),
            onPressed: _playSong,
            child: Ink(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffBE4040),
                    Color(0xff632293),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.play_arrow_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
