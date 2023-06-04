import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiDataSource {
  final String _baseUrl = "https://www.omdbapi.com/?apikey=46539e83&s=avengers";

  static ApiDataSource instance = ApiDataSource();

  Future<List<ProductModel>> loadProducts(String kategori) async {
    final response = await http.get(Uri.parse("$_baseUrl"));

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body)["Search"];
      final List<ProductModel> products = productsJson.map((product) => ProductModel.fromJson(product)).toList();
      return products;
    }
    final String errorMessage = "Failed to load products";
    print(errorMessage);
    throw Exception(errorMessage);
  }
}
