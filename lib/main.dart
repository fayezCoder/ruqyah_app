import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruqyah_app/screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/ruqyah_screen.dart';
import 'screens/quran_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/adhkar_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/theme_provider.dart';
import 'services/preferences_service.dart';
import 'providers/text_settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load initial theme
  final isDarkMode = await PreferencesService.isDarkMode();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider()..setInitialTheme(isDarkMode),
        ),
        ChangeNotifierProvider(
          create: (_) => TextSettingsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'تطبيق الرقية الشرعية',
          theme: ThemeData(
            primaryColor: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 1,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: GoogleFonts.cairoTextTheme(),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.grey[900],
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[900],
              foregroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
          ),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/': (context) => const HomeScreen(),
            '/ruqyah': (context) => const RuqyahScreen(),
            '/quran': (context) => const QuranScreen(),
            '/favorites': (context) => const FavoritesScreen(),
            '/adhkar': (context) => const AdhkarScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar', 'SA'),
        );
      },
    );
  }
}
