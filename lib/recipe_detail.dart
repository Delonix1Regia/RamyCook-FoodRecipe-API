import 'package:flutter/material.dart';
import 'services/api_service.dart';

class RecipeDetail extends StatelessWidget {
  final String imagePath;
  final String title;
  final String recipeId;

  const RecipeDetail({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.recipeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: ApiService().fetchRecipeSteps(int.parse(recipeId)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No data available.',
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            final steps = snapshot.data ?? [];

            // Mengumpulkan bahan tanpa duplikasi
            final ingredients = <String>{};
            for (var step in steps) {
              if (step['ingredients'] != null) {
                for (var ingredient in step['ingredients']) {
                  ingredients.add(ingredient['name'] ?? 'Unknown');
                }
              }
            }

            // Mengumpulkan peralatan (equipment) tanpa duplikasi
            final equipmentSet = <String>{};
            for (var step in steps) {
              if (step['equipment'] != null && step['equipment'].isNotEmpty) {
                for (var equipment in step['equipment']) {
                  equipmentSet.add(equipment['name'] ?? 'Unknown');
                }
              }
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        imagePath.isNotEmpty
                            ? imagePath
                            : 'https://wartakonstruksi.com/upload/image_not_found.jpg',
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingredients Section
                    Text(
                      'Ingredients',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (ingredients.isEmpty)
                      const Text(
                        'No ingredients available.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    for (var ingredient in ingredients)
                      Text(
                        '- $ingredient',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Equipments Section
                    Text(
                      'Equipments',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (equipmentSet.isEmpty)
                      const Text(
                        'No equipment available.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    for (var equipment in equipmentSet)
                      Text(
                        '- $equipment',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Cooking Steps Section
                    Text(
                      'Cooking Steps',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (steps.isEmpty)
                      const Text(
                        'No steps available.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    for (var step in steps)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Step ${step['number'] ?? 'N/A'}: ${step['step'] ?? 'No description'}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
