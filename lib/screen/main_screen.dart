import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musica_music_player/constants/color_constants.dart';
import 'package:musica_music_player/constants/value_constants.dart';
import 'package:musica_music_player/widgets/my_app_bar.dart';
import 'package:musica_music_player/widgets/my_list_view_container.dart';
import 'package:musica_music_player/widgets/my_text.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final GlobalKey _appBarKey = GlobalKey();

  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        key: _appBarKey,
        actions: const [],
        centerTitle: false,
        title: Text(
          "Musica",
          style: GoogleFonts.cookie(
            textStyle: const TextStyle(
              color: secondaryColor500,
              fontSize: 36,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: primaryColor300,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: MyText(
                  "Your Music",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              FutureBuilder<List<SongModel>>(
                  future: _audioQuery.querySongs(),
                  builder: (context, item) {
                    if (item.data == null) {
                      return const CircularProgressIndicator();
                    }
                    if (item.data!.isEmpty) {
                      return const Center(
                        child: Text("Nothing found!"),
                      );
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          (kToolbarHeight + 176),
                      child: ListView.builder(
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) => MyListViewContainer(
                          title: item.data![index].title,
                          artist: item.data![index].artist ?? "No Artist",
                          artwork: QueryArtworkWidget(
                            id: item.data![index].id,
                            type: ArtworkType.ARTIST,
                          ),
                          uri: item.data![index].uri!,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
