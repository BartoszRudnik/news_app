import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  final viewKey = GlobalKey();

  int index = 0;

  @override
  void initState() {
    super.initState();

    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
        selected: index,
        onChanged: (value) => setState(
          () => index = value,
        ),
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.news),
            title: const Text("Top headliness"),
            body: Container(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.business_center_logo),
            title: const Text("Business"),
            body: Container(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.laptop_secure),
            title: const Text("Technology"),
            body: Container(),
          ),
        ],
      ),
    );
  }

  @override
  void onWindowClose() async {
    final isPreventClose = await windowManager.isPreventClose();

    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (_) => ContentDialog(
          title: const Text(
            "Confirm close?",
          ),
          content: const Text(
            "Are you sure you want to close this app?",
          ),
          actions: [
            FilledButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FilledButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                windowManager.destroy();
              },
            ),
          ],
        ),
      );
    }
  }
}
