import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/services/services.dart';
import 'package:news_app/themes/theme.dart';
import 'package:news_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ListaCategorias(),
            if (newsService.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator.adaptive())),
            Expanded(child: ListaNoticias(noticias: newsService.getArticulosCategoriaSeleccionada))
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: newsService.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = newsService.categories[index];
          final cName = category.name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categoria: category),
                const SizedBox(height: 5),
                Text(
                  cName[0].toUpperCase() + cName.substring(1),
                  style: TextStyle(color: newsService.selectedCategory == category.name ? miTema.colorScheme.secondary : Colors.white),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;
  const _CategoryButton({
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    final nuevoServicio = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: nuevoServicio.selectedCategory == categoria.name ? miTema.colorScheme.secondary : Colors.white,
          ),
        ),
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            categoria.icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
