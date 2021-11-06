import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musica_music_player/constants/color_constants.dart';
import 'package:musica_music_player/widgets/my_text.dart';
import 'package:musica_music_player/widgets/null_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongScreen extends StatefulWidget {
  final String source;
  final String title;
  final String artist;
  final QueryArtworkWidget artwork;

  SongScreen({
    required this.title,
    required this.artist,
    required this.source,
    required this.artwork,
  });
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _SongScreen(
        title: title,
        artist: artist,
        source: source,
        artwork: artwork,
      );
}

class _SongScreen extends State<SongScreen> {
  final String source;
  final String title;
  final String artist;
  final QueryArtworkWidget artwork;
  final AudioPlayer _audioPlayer = AudioPlayer();

  _SongScreen({
    required this.title,
    required this.artist,
    required this.source,
    required this.artwork,
  });

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(source)));
    } catch (e) {
      Center(
        child: MyText(
          "Error loading audio source: $e",
        ),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _audioPlayer.play();
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
              Wrap(alignment: WrapAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 310,
                      height: 205,
                      // color: secondaryColor500,
                      child: QueryArtworkWidget(
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(10)),
                        id: artwork.id,
                        type: artwork.type,
                        nullArtworkWidget: const NullArtworkWidget(
                          artworkSize: 98,
                        ),
                        artworkFit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                Column(children: [
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
                ]),
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // StreamBuilder<PlayerState>(
                    //     stream: _audioPlayer.playerStateStream,
                    //     builder: (context, snapshot) {
                    //       final playerState = snapshot.data;
                    //       return _playShuffle(playerState!);
                    //     }),
                    // StreamBuilder<PlayerState>(
                    //     stream: _audioPlayer.playerStateStream,
                    //     builder: (context, snapshot) {
                    //       final playerState = snapshot.data;
                    //       return _playPrev(playerState!);
                    //     }),
                    StreamBuilder<PlayerState>(
                        stream: _audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          return _playButton(playerState!);
                        }),
                    // StreamBuilder<PlayerState>(
                    //     stream: _audioPlayer.playerStateStream,
                    //     builder: (context, snapshot) {
                    //       final playerState = snapshot.data;
                    //       return _playNext(playerState!);
                    //     }),
                    // StreamBuilder<PlayerState>(
                    //     stream: _audioPlayer.playerStateStream,
                    //     builder: (context, snapshot) {
                    //       final playerState = snapshot.data;
                    //       return _playRepeat(playerState!);
                    //     }),
                  ],
                ),
              ]),
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
        elevation: 10,
      ),
      onPressed: playing ? _audioPlayer.pause : _audioPlayer.play,
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
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  Widget _playNext(PlayerState playerState) {
    return IconButton(
      icon: const Icon(
        Icons.skip_next_rounded,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }

  Widget _playPrev(PlayerState playerState) {
    return IconButton(
      icon: const Icon(
        Icons.skip_previous_rounded,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }

  Widget _playShuffle(PlayerState playerState) {
    final bool isShuffle = _audioPlayer.shuffleModeEnabled;
    return IconButton(
      icon: Icon(
        isShuffle ? Icons.shuffle_on_rounded : Icons.shuffle_rounded,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }

  Widget _playRepeat(PlayerState playerState) {
    return IconButton(
      icon: const Icon(
        Icons.repeat_rounded,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}
