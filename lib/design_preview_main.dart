import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_preview_theme.dart';
import 'package:karing/screens/design_preview_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KaringDesignPreviewApp());
}

class KaringDesignPreviewApp extends StatefulWidget {
  const KaringDesignPreviewApp({super.key});

  @override
  State<KaringDesignPreviewApp> createState() => _KaringDesignPreviewAppState();
}

class _KaringDesignPreviewAppState extends State<KaringDesignPreviewApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karing UI Preview',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: KaringPreviewTheme.light(),
      darkTheme: KaringPreviewTheme.dark(),
      home: DesignPreviewScreen(
        themeMode: _themeMode,
        onThemeModeChanged: (value) {
          setState(() {
            _themeMode = value;
          });
        },
      ),
    );
  }
}
