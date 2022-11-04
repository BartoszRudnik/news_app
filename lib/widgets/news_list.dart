import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app/model/news_page.dart';
import 'package:news_app/widgets/news_item.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({
    Key? key,
    required this.newsPage,
  }) : super(key: key);

  final NewsPage newsPage;

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          widget.newsPage.title,
        ),
      ),
      content: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 270,
          mainAxisExtent: 290,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: 30,
        itemBuilder: (ctx, index) {
          return const NewsItem();
        },
      ),
    );
  }
}
