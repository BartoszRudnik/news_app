import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app/screen/home_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then(
    (_) async {
      await windowManager.setTitle(
        'XCA News',
      );

      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
      );

      await windowManager.setBackgroundColor(
        Colors.transparent,
      );

      await windowManager.setSize(
        const Size(
          755,
          545,
        ),
      );

      await windowManager.setMinimumSize(
        const Size(
          755,
          545,
        ),
      );

      await windowManager.center();

      await windowManager.show();

      await windowManager.setSkipTaskbar(
        false,
      );
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "XCA News",
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.orange,
      ),
      home: const HomeScreen(),
    );
  }
}
