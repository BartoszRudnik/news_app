import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app/model/article_category.dart';
import 'package:news_app/model/news_page.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  final viewKey = GlobalKey();

  int index = 0;
  final List<NewsPage> pages = const [
    NewsPage(title: 'Top Headlines', iconData: FluentIcons.news, category: ArticleCategory.general),
    NewsPage(title: 'Business', iconData: FluentIcons.business_center_logo, category: ArticleCategory.business),
    NewsPage(title: 'Technology', iconData: FluentIcons.laptop_secure, category: ArticleCategory.technology),
    NewsPage(title: 'Entertainment', iconData: FluentIcons.my_movies_t_v, category: ArticleCategory.entertainment),
    NewsPage(title: 'Sports', iconData: FluentIcons.more_sports, category: ArticleCategory.sports),
    NewsPage(title: 'Science', iconData: FluentIcons.communications, category: ArticleCategory.science),
    NewsPage(title: 'Health', iconData: FluentIcons.health, category: ArticleCategory.health),
  ];

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
        items: pages
            .map<NavigationPaneItem>(
              (e) => PaneItem(
                icon: Icon(e.iconData),
                title: Text(e.title),
                body: Container(),
              ),
            )
            .toList(),
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
