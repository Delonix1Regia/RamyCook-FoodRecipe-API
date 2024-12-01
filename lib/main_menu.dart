import 'package:flutter/material.dart';
import 'Services/api_service.dart';
import 'category_tab.dart';
import 'recipe_card.dart';
import 'recipe_detail.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final ApiService _apiService = ApiService();
  String currentCategory = 'All';
  bool isLoading = true;
  List<dynamic> recipes = [];

  Future<void> fetchRecipes() async {
    setState(() {
      isLoading = true;
    });

    try {
      String query = currentCategory.toLowerCase();
      List<dynamic> data = await _apiService.getRecipes(query: query);

      setState(() {
        recipes = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching recipes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  void _changeCategory(String category) {
    setState(() {
      currentCategory = category;
    });
    fetchRecipes(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Recipes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryTab(
                    text: 'All',
                    isSelected: currentCategory == 'All',
                    onTap: () => _changeCategory('All'),
                  ),
                  const SizedBox(width: 18),
                  CategoryTab(
                    text: 'Breakfast',
                    isSelected: currentCategory == 'Breakfast',
                    onTap: () => _changeCategory('Breakfast'),
                  ),
                  const SizedBox(width: 18),
                  CategoryTab(
                    text: 'Lunch',
                    isSelected: currentCategory == 'Lunch',
                    onTap: () => _changeCategory('Lunch'),
                  ),
                  const SizedBox(width: 18),
                  CategoryTab(
                    text: 'Dinner',
                    isSelected: currentCategory == 'Dinner',
                    onTap: () => _changeCategory('Dinner'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (recipes.isEmpty)
              const Center(
                child: Text(
                  'No recipes found',
                  style: TextStyle(color: Colors.white),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return RecipeCard(
                      imagePath: recipe['image'] ??
                          'https://wartakonstruksi.com/upload/image_not_found.jpg',
                      title: recipe['title'] ?? 'No Title',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetail(
                              imagePath: recipe['image'] ?? '',
                              title: recipe['title'] ?? 'No title',
                              recipeId: recipe['id'].toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
