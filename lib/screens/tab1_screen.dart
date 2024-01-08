import 'package:flutter/material.dart';
import 'package:news_app/services/services.dart';
import 'package:news_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: (newsService.headlines.isEmpty)
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListaNoticias(noticias: newsService.headlines)
        )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
