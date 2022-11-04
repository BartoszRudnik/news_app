import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:news_app/model/article.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final typography = FluentTheme.of(context).typography;

    return Card(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              color: material.Colors.grey[700],
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                imageErrorBuilder: (context, error, stackTrace) => Icon(
                  material.Icons.image,
                  color: material.Colors.grey[300],
                ),
                fit: BoxFit.cover,
                image: article.urlToImage ?? "",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Text(
                article.title,
                style: typography.title!.apply(
                  fontSizeFactor: 0.55,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    article.captionText(),
                    style: typography.bodyLarge!.apply(
                      fontSizeFactor: 0.8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropDownButton(
                  title: const Icon(
                    FluentIcons.share,
                  ),
                  items: [
                    MenuFlyoutItem(
                      onPressed: () {},
                      text: const Text('Open in browser'),
                      leading: const Icon(
                        FluentIcons.edge_logo,
                      ),
                    ),
                    MenuFlyoutItem(
                      onPressed: () {},
                      text: const Text('Send'),
                      leading: const Icon(
                        FluentIcons.send,
                      ),
                    ),
                    MenuFlyoutItem(
                      onPressed: () {},
                      text: const Text('Copy URL'),
                      leading: const Icon(
                        FluentIcons.copy,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
