import 'package:flutter/material.dart';
import '../constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  List<String> surahList = [];

  List<String> filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    // Assuming arabicName is a list of maps
    surahList = arabicName.map((item) => item['name'] as String).toList();
    filteredSurahs = surahList;
  }

  void _filterSurahs(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSurahs = surahList;
      } else {
        filteredSurahs = surahList
            .where((surah) => surah.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.arrow_back_outlined)],
        title: const Text('Search Surah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value) {
                _filterSurahs(value);
              },
              controller: searchController,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                contentPadding: const EdgeInsets.all(10.0),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintText: 'Search Surah...',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredSurahs[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahDetailScreen(surahName: filteredSurahs[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final String surahName;

  const SurahDetailScreen({super.key, required this.surahName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
      ),
      body: Center(
        child: Text('Displaying Ayahs for $surahName'),
      ),
    );
  }
}
