import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';

import 'app/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TrainingMenuForHiveAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF5722); // Deep Orange 500
    const secondaryColor = Color(0xFFFFEB3B); // Yellow 500
    const onPrimaryColor = Colors.white;
    const onSecondaryColor = Color(0xFF212121);
    const surfaceColor = Color(0xFFFFF3E0);
    const backgroundColor = Colors.white;
    const onSurfaceAndBackgroundColor = Color(0xFF212121); // テキストの基本色
    const errorColor = Color(0xFFD32F2F);

    return MaterialApp.router(
      title: 'Training Creator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: onPrimaryColor,
          secondary: secondaryColor,
          onSecondary: onSecondaryColor,

          surface: surfaceColor,
          onSurface: onSurfaceAndBackgroundColor,
          error: errorColor,
          onError: Colors.white,
        ),

        scaffoldBackgroundColor: backgroundColor,

        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontFamily: 'sans-serif',
            color: onPrimaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          iconTheme: const IconThemeData(color: onPrimaryColor, size: 26),
        ),

        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: onSurfaceAndBackgroundColor,
            letterSpacing: 0.2,
          ),
          headlineMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: onSurfaceAndBackgroundColor,
            letterSpacing: 0.2,
          ),
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: onSurfaceAndBackgroundColor,
            letterSpacing: 0.1,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: onSurfaceAndBackgroundColor,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: onSurfaceAndBackgroundColor,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: onSurfaceAndBackgroundColor,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: onSurfaceAndBackgroundColor.withValues(alpha: 0.85),
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: onSurfaceAndBackgroundColor.withValues(alpha: 0.85),
            height: 1.4,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: onSurfaceAndBackgroundColor.withValues(alpha: 0.60),
            height: 1.3,
          ),
          labelLarge: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: onPrimaryColor,
            letterSpacing: 0.5,
          ),
          // ElevatedButtonのテキスト
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: onSurfaceAndBackgroundColor.withValues(alpha: 0.7),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: onPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            textStyle: const TextStyle(
              // labelLarge が使われることが多いが、明示的に指定
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: onPrimaryColor, // 明示的に色を指定
            ),
            elevation: 3,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(color: primaryColor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceColor.withValues(alpha: 0.8),
          // 少し透明度を持たせるか、別のはっきりした色
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: primaryColor, width: 2.0),
          ),
          labelStyle: TextStyle(
            color: onSurfaceAndBackgroundColor.withValues(alpha: 0.7),
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: onSurfaceAndBackgroundColor.withValues(alpha: 0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),

        cardTheme: CardTheme(
          elevation: 2, // 少し抑えめの影
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: surfaceColor,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: secondaryColor, // アクセントカラー
          foregroundColor: onSecondaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
        ),

        iconTheme: IconThemeData(
          color: onSurfaceAndBackgroundColor.withValues(alpha: 0.8),
          size: 24,
        ),

        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: primaryColor,
          linearTrackColor: Colors.grey[300],
          circularTrackColor: Colors.grey[300],
        ),

        tabBarTheme: TabBarTheme(
          labelColor: primaryColor,
          unselectedLabelColor: onSurfaceAndBackgroundColor.withValues(
            alpha: 0.7,
          ),
          indicatorColor: primaryColor,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      routerConfig: myAppRouter,
    );
  }
}
