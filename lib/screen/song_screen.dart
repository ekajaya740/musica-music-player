import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musica_music_player/constants/color_constants.dart';
import 'package:musica_music_player/widgets/my_text.dart';
import 'package:musica_music_player/widgets/null_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongScreen extends StatefulWidget {
  final String source;
  final String title;
  final QueryArtworkWidget artwork;
  final String artist;
  final AudioPlayer audioPlayer;
  final List<SongModel> songs;
  final int index;

  SongScreen({
    required this.title,
    required this.artist,
    required this.artwork,
    required this.source,
    required this.audioPlayer,
    required this.songs,
    required this.index,
  });
  @override
  State<StatefulWidget> createState() => _SongScreen(
        title: title,
        artist: artist,
        artwork: artwork,
        source: source,
        audioPlayer: audioPlayer,
        songs: songs,
        index: index,
      );
}

class _SongScreen extends State<SongScreen> {
  final String source;
  final String title;
  final QueryArtworkWidget artwork;
  final String artist;
  final AudioPlayer audioPlayer;
  final List<SongModel> songs;
  final int index;

  _SongScreen({
    required this.title,
    required this.artist,
    required this.artwork,
    required this.source,
    required this.audioPlayer,
    required this.songs,
    required this.index,
  });

  @override
  void initState() {
    super.initState();
    // audioPlayer.setUrl(source);
    _init();
  }

  Future<void> _init() async {
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(songs[index].uri!)));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    audioPlayer.play();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 48,
            horizontal: 19,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    constraints: const BoxConstraints(
                      maxWidth: 24,
                      maxHeight: 24,
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.expand_more_rounded,
                    ),
                    color: Colors.white,
                  ),
                  const MyText(
                    "NOW PLAYING",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                ],
              ),
              // SizedBox(
              //   height: 100,
              // ),
              Wrap(alignment: WrapAlignment.center, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 310,
                    height: 205,
                    child: QueryArtworkWidget(
                      id: artwork.id,
                      type: artwork.type,
                      nullArtworkWidget:
                          const NullArtworkWidget(artworkSize: 148),
                      artworkFit: BoxFit.scaleDown,
                      artworkBorder: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(children: [
                      MyText(
                        title,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        maxLines: 2,
                      ),
                      MyText(
                        artist,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor300,
                      ),
                    ])),
              ]),

              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // StreamBuilder<bool>(
                    //     stream: audioPlayer.shuffleModeEnabledStream,
                    //     builder: (context, snapshot) {
                    //       return _playShuffle(context, snapshot.data ?? false);
                    //     }),
                    // StreamBuilder<SequenceState?>(
                    //     stream: audioPlayer.sequenceStateStream,
                    //     builder: (_, __) {
                    //       return _playPrev();
                    //     }),
                    StreamBuilder<PlayerState>(
                        stream: audioPlayer.playerStateStream,
                        builder: (_, snapshot) {
                          final playerState = snapshot.data;
                          return _playButton(playerState!);
                        }),
                    // StreamBuilder<SequenceState?>(
                    //     stream: audioPlayer.sequenceStateStream,
                    //     builder: (_, __) {
                    //       return _playNext();
                    //     }),
                    // StreamBuilder<LoopMode>(
                    //     stream: audioPlayer.loopModeStream,
                    //     builder: (context, snapshot) {
                    //       return _playRepeat(
                    //           context, snapshot.data ?? LoopMode.off);
                    //     }),
                  ],
                )
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget _playButton(PlayerState playerState) {
    final bool playing = playerState.playing;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shape: const CircleBorder(),
        elevation: 1,
      ),
      onPressed: () {
        playing ? audioPlayer.pause : audioPlayer.play;
      },
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 20,
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: Ink(
          width: 80,
          height: 80,
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
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _playNext() {
  //   return IconButton(
  //     icon: const Icon(
  //       Icons.skip_next_rounded,
  //       color: Colors.white,
  //     ),
  //     onPressed: () {
  //       audioPlayer.seekToNext();
  //     },
  //   );
  // }

  // Widget _playPrev() {
  //   return IconButton(
  //     icon: const Icon(
  //       Icons.skip_previous_rounded,
  //       color: Colors.white,
  //     ),
  //     onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
  //   );
  // }

//   Widget _playShuffle(BuildContext context, bool isShuffle) {
//     return IconButton(
//       icon: Icon(
//         isShuffle ? Icons.shuffle_on_rounded : Icons.shuffle_rounded,
//         color: Colors.white,
//       ),
//       onPressed: () async {
//         final enable = !isShuffle;
//         if (enable) {
//           await audioPlayer.shuffle();
//         }
//         await audioPlayer.setShuffleModeEnabled(enable);
//       },
//     );
//   }

//   Widget _playRepeat(BuildContext context, LoopMode loopMode) {
//     final _repeatIcon = [
//       const Icon(
//         Icons.repeat_rounded,
//         color: Colors.white,
//       ),
//       const Icon(
//         Icons.repeat_on_rounded,
//         color: Colors.white,
//       ),
//       const Icon(
//         Icons.repeat_one_rounded,
//         color: Colors.white,
//       ),
//     ];
//     const cycleModes = [
//       LoopMode.off,
//       LoopMode.all,
//       LoopMode.one,
//     ];
//     final index = cycleModes.indexOf(loopMode);
//     return IconButton(
//       icon: _repeatIcon[index],
//       onPressed: () {
//         audioPlayer.setLoopMode(
//             cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
//       },
//     );
//   }
}
