import 'package:db_miner/provider/like_provider.dart';
import 'package:db_miner/screens/pages/liked_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../screens/pages/home_page.dart';
import 'screens/pages/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffcdc1ff),
          ),
          scaffoldBackgroundColor: const Color(0xffcdc1ff),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: "splash",
        routes: {
          '/': (_) => const HomePage(),
          'splash': (_) => const Splash(),
          'liked': (_) => const LikedPage(),
        },
      ),
    ),
  );
}
