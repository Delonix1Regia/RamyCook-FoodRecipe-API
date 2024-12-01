import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const RecipeCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Set the background color to white
      elevation: 4, // Optional: gives the card a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Optional: adds rounded corners
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(10), // Match the card's border radius
        child: Stack(
          children: [
            // Display the image
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Match the card's border radius
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            // Display the text over the image at the bottom left corner
            Positioned(
              left: 8, // Padding from the left
              bottom: 8, // Padding from the bottom
              child: Container(
                color: Colors.black
                    .withOpacity(0.8), // Semi-transparent background for text
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // White text for contrast against the background
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
