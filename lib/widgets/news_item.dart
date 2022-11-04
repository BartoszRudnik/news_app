import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:news_app/model/article.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final typography = FluentTheme.of(context).typography;

    return HoverButton(
      onPressed: () async {
        if (!await launchUrlString(article.uri)) {
          log('Could not launch ${article.uri}');
        }
      },
      cursor: SystemMouseCursors.click,
      builder: (p0, state) => Card(
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
                        onPressed: () async {
                          if (!await launchUrlString(article.uri)) {
                            log('Could not launch ${article.uri}');
                          }
                        },
                        text: const Text('Open in browser'),
                        leading: const Icon(
                          FluentIcons.edge_logo,
                        ),
                      ),
                      MenuFlyoutItem(
                        onPressed: () async {
                          await Share.share(
                            'Checkout this article ${article.uri}',
                          );
                        },
                        text: const Text('Send'),
                        leading: const Icon(
                          FluentIcons.send,
                        ),
                      ),
                      MenuFlyoutItem(
                        onPressed: () {
                          FlutterClipboard.copy(
                            article.uri,
                          ).then(
                            (value) => showCopiedSnackbar(
                              context,
                              article.uri,
                            ),
                          );
                        },
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
      ),
    );
  }

  void showCopiedSnackbar(BuildContext context, String copiedText) {
    showSnackbar(
      context,
      Snackbar(
        content: RichText(
          text: TextSpan(
            text: 'Copied ',
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: copiedText,
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        extended: true,
      ),
    );
  }
}
