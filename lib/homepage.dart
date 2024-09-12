import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/drawer.dart';
import 'package:quran/layout/search_screen.dart';
import 'package:quran/surah_builder.dart';
import 'arabic sura number.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Go to bookmark',
          backgroundColor: Colors.black,
          onPressed: () async {
            fabIsClicked = true;
            if (await readBookmark() == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SurahBuilder(
                            arabic: quran[0],
                            sura: bookmarkedSura - 1,
                            suraName: arabicName[bookmarkedSura - 1]['name'],
                            ayah: bookmarkedAyah,
                          )));
            }
          },
          child: const Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       navigateTo(context, const SearchScreen());
          //     },
          //     icon: const Icon(Icons.search, color: Colors.white),
          //   ),
          // ],
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            //''
            "الفهرس",
            // "Quran",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'quran',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ]),
          ),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
          future: readJson(),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                print('Snapshot Data: ${snapshot.data}');
                return indexCreator(snapshot.data, context);
              } else {
                return const Text('No data available');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }

  Container indexCreator(quran, context) {
    return Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: ListView(
        children: [
          for (int i = 0; i < 114; i++)
            Container(
              color: i % 2 == 0
                  ? const Color.fromARGB(255, 253, 247, 230)
                  : const Color.fromARGB(255, 253, 247, 240),
              child: TextButton(
                child: Row(
                  children: [
                    ArabicSuraNumber(i: i),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      arabicName[i]['name'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'quran',
                          shadows: [
                            Shadow(
                              offset: Offset(.5, .5),
                              blurRadius: 1.0,
                              // color: Colors.white,
                            )
                          ]),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                onPressed: () {
                  fabIsClicked = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SurahBuilder(
                              arabic: quran[0],
                              sura: i,
                              suraName: arabicName[i]['name'],
                              ayah: 0,
                            )),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
