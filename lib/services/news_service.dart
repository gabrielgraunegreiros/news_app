import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService extends ChangeNotifier {
  final String _baseUrl = 'newsapi.org';
  final String _apiKey = 'f0ac5c71241b41f5a357a5a259edadba';
  final String _country = 'us';

  bool _isLoading = false;

  List<Article> headlines = [];

  String _selectedCategory = 'business';
  //business - entertainment - general - health
  //science - sports - technology
  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    categories.forEach((categoria) {
      categoryArticles[categoria.name] = [];
    });
    getArticlesByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool valor) {
    _isLoading = valor;
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada {
    return categoryArticles[selectedCategory]!;
  }

  getTopHeadlines() async {
    final url = Uri.https(_baseUrl, 'v2/top-headlines', {'apiKey': _apiKey, 'country': _country});
    final res = await http.get(url);

    final newsResponse = NewsResponse.fromJson(res.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'v2/top-headlines', {'apiKey': _apiKey, 'country': _country, 'category': category});

    final res = await http.get(url);

    final newsResponse = NewsResponse.fromJson(res.body);

    categoryArticles[category]?.addAll(newsResponse.articles);

    isLoading = false;
    notifyListeners();
  }
}
