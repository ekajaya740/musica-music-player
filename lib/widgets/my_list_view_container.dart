import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musica_music_player/constants/color_constants.dart';
import 'package:musica_music_player/screen/song_screen.dart';
import 'package:musica_music_player/widgets/null_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'my_text.dart';

class MyListViewContainer extends StatefulWidget {
  final QueryArtworkWidget artwork;
  final int index;
  final List<SongModel> songs;

  const MyListViewContainer({
    Key? key,
    required this.artwork,
    required this.index,
    required this.songs,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _MyListViewContainer(
        artwork: artwork,
        index: index,
        songs: songs,
      );
}

class _MyListViewContainer extends State<MyListViewContainer> {
  final QueryArtworkWidget artwork;
  final int index;
  final List<SongModel> songs;
  final AudioPlayer audioPlayer = AudioPlayer();

  _MyListViewContainer({
    required this.artwork,
    required this.index,
    required this.songs,
  });

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      for (int i = 0; i < songs.length; i++)
        AudioSource.uri(Uri.parse(songs[i].uri!))
    ]))
        .catchError((error) {
      print("An error occured $error");
    });
  }

  _playSong() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongScreen(
          artist: songs[index].artist.toString(),
          source: songs[index].uri.toString(),
          title: songs[index].title,
          artwork: artwork,
          audioPlayer: audioPlayer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _playSong,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: QueryArtworkWidget(
                  id: artwork.id,
                  type: artwork.type,
                  nullArtworkWidget: NullArtworkWidget(
                    artworkSize: 40,
                  ),
                  artworkFit: BoxFit.scaleDown,
                  artworkBorder: const BorderRadius.all(
                    Radius.circular(10),
                  ),
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
                          songs[index].title,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 220,
                        child: MyText(
                          songs[index].artist.toString(),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor300,
                        ),
                      ),
                    ]),
              ),
            ]),
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
      ),
    );
  }
}
