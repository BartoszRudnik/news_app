import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/news_page.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/widgets/news_item.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({
    Key? key,
    required this.newsAPI,
    required this.newsPage,
  }) : super(key: key);

  final NewsPage newsPage;
  final NewsAPI newsAPI;

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();

    futureArticles = widget.newsAPI.getArticles(widget.newsPage.category);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          widget.newsPage.title,
        ),
      ),
      content: FutureBuilder(
        future: futureArticles,
        builder: (context, loadingResult) {
          if (loadingResult.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 270,
                mainAxisExtent: 290,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: loadingResult.data!.length,
              itemBuilder: (ctx, index) => NewsItem(
                article: loadingResult.data![index],
              ),
            );
          } else if (loadingResult.hasError) {
            return Center(
              child: Column(
                children: [
                  const Text(
                    'Error!',
                  ),
                  FilledButton(
                    child: const Text('Try again!'),
                    onPressed: () {
                      setState(
                        () {
                          futureArticles = widget.newsAPI.getArticles(
                            widget.newsPage.category,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (loadingResult.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
