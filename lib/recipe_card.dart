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
      color: Colors.white, 
      elevation: 4, 
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), 
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(10), 
        child: Stack(
          children: [
            // Display the image
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), 
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 8, 
              bottom: 8, 
              child: Container(
                color: Colors.black
                    .withOpacity(0.8), 
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, 
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
