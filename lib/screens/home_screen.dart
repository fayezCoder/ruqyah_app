import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final List<Map<String, dynamic>> categories = [
      {
        'title': 'القرآن الكريم',
        'icon': Icons.menu_book,
        'color': const Color(0xFF81B29A),
        'route': '/quran',
      },
      {
        'title': 'الرقية الشرعية',
        'icon': Icons.healing,
        'color': const Color(0xFF9B8EA9),
        'route': '/ruqyah',
      },
      {
        'title': 'المفضلة',
        'icon': Icons.favorite,
        'color': const Color(0xFFF4ACB7),
        'route': '/favorites',
      },
      {
        'title': 'أذكار اليوم',
        'icon': Icons.wb_sunny,
        'color': const Color(0xFFE9C46A),
        'route': '/adhkar',
      },
      {
        'title': 'الإعدادات',
        'icon': Icons.settings,
        'color': const Color(0xFF95A5A6),
        'route': '/settings',
      },
    ];

    return Theme(
      data: themeProvider.theme,
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? const Color(0xFF2B2B2B)
            : const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text(
            'الرئيسية',
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              themeProvider.isDarkMode ? const Color(0xFF2B2B2B) : Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]!
                        : Colors.green.shade50,
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]!
                        : Colors.green.shade100,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]!
                      : Colors.green.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'صدقة جارية',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'عن والدي سعدون بن سمران المطيري',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[300]
                          : Colors.green[700],
                    ),
                  ),
                  Text(
                    'رحمه الله',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[400]
                          : Colors.green[600],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    title: category['title'],
                    icon: category['icon'],
                    color: category['color'],
                    route: category['route'],
                    onTap: () {
                      if (category['route'] != null) {
                        Navigator.pushNamed(context, category['route']);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
