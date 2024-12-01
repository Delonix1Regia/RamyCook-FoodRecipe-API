import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.spoonacular.com';
  final String apiKey = '47ab9020ea4a44608e2b9b430cd4a370';
  final http.Client client;

  ApiService({http.Client? httpClient}) : client = httpClient ?? http.Client();

  Future<List<dynamic>> getRecipes({String query = ''}) async {
    final uri =
        Uri.parse('$baseUrl/recipes/complexSearch?apiKey=$apiKey&query=$query');
    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] == null) throw Exception('No results found');
        return data['results'];
      } else {
        throw Exception(
            'Failed to load recipes. Status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error loading recipes: $error');
    }
  }

  Future<List<dynamic>> fetchRecipeSteps(int recipeId) async {
    final uri = Uri.parse(
        '$baseUrl/recipes/$recipeId/analyzedInstructions?apiKey=$apiKey');
    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.isNotEmpty ? data[0]['steps'] : [];
      } else {
        throw Exception(
            'Failed to fetch recipe steps. Status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching recipe steps: $error');
    }
  }

  Future<List<dynamic>> searchIngredients(String query) async {
    final uri = Uri.parse(
        '$baseUrl/food/ingredients/search?query=$query&apiKey=$apiKey');
    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] == null) throw Exception('No ingredients found');
        return data['results'];
      } else {
        throw Exception(
            'Failed to fetch ingredients. Status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching ingredients: $error');
    }
  }
}
