import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/surah.dart';

class QuranApiService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';
  static const String cacheFileName = 'quran_cache.json';

  Future<List<Surah>> fetchAllSurahs() async {
    try {
      // Check if we have cached data
      final cachedSurahs = await _loadFromCache();
      if (cachedSurahs != null) {
        return cachedSurahs;
      }

      List<Surah> allSurahs = [];
      
      // Fetch all 114 surahs
      for (int i = 1; i <= 114; i++) {
        final response = await http.get(Uri.parse('$baseUrl/surah/$i/ar.alafasy'));
        
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final surahData = data['data'];
          
          // Extract ayahs
          final List<dynamic> ayahs = surahData['ayahs'];
          String content = 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n';
          
          // Skip bismillah for surah 1 and 9
          if (i == 1 || i == 9) {
            content = '';
          }
          
          // Combine all ayahs
          for (var ayah in ayahs) {
            content += '${ayah['text']} ﴿${ayah['numberInSurah']}﴾ ';
          }
          
          allSurahs.add(Surah(
            name: surahData['name'],
            content: content.trim(),
            bismillah: !(i == 1 || i == 9),
            number: i,
          ));
        }
      }

      // Cache the fetched data
      await _saveToCache(allSurahs);
      
      return allSurahs;
    } catch (e) {
      print('Error fetching surahs: $e');
      // Return empty list in case of error
      return [];
    }
  }

  Future<void> _saveToCache(List<Surah> surahs) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$cacheFileName');
      
      final List<Map<String, dynamic>> surahsMap = surahs.map((surah) => {
        'name': surah.name,
        'content': surah.content,
        'bismillah': surah.bismillah,
        'number': surah.number,
      }).toList();
      
      await file.writeAsString(json.encode(surahsMap));
    } catch (e) {
      print('Error saving cache: $e');
    }
  }

  Future<List<Surah>?> _loadFromCache() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$cacheFileName');
      
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> surahsMap = json.decode(contents);
        
        return surahsMap.map((map) => Surah(
          name: map['name'],
          content: map['content'],
          bismillah: map['bismillah'],
          number: map['number'],
        )).toList();
      }
    } catch (e) {
      print('Error loading cache: $e');
    }
    return null;
  }
}
