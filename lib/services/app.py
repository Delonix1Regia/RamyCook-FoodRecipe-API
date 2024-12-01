from flask import Flask, jsonify, request

app = Flask(__name__)

# Data contoh
recipes = [
    {"id": 1, "title": "Spaghetti Carbonara", "category": "Dinner"},
    {"id": 2, "title": "Pancakes", "category": "Breakfast"},
    {"id": 3, "title": "Bubur Ayam", "category": "Breakfast"},
    {"id": 4, "title": "Nasi Uduk", "category": "Breakfast"},
    {"id": 5, "title": "Nasi Padang", "category": "Lunch"},
    {"id": 6, "title": "Soto Ayam", "category": "Lunch"},
    {"id": 7, "title": "Omelet", "category": "Brunch"},
    {"id": 8, "title": "Pancake", "category": "Dinner"}
]

# Route untuk mengambil semua resep
@app.route('/recipes', methods=['GET'])
def get_recipes():
    return jsonify(recipes)

# Route untuk mengambil resep berdasarkan ID
@app.route('/recipes/<int:id>', methods=['GET'])
def get_recipe(id):
    recipe = next((r for r in recipes if r['id'] == id), None)
    if recipe is None:
        return jsonify({"error": "Recipe not found"}), 404
    return jsonify(recipe)

# Route untuk menambahkan resep baru
@app.route('/recipes', methods=['POST'])
def create_recipe():
    new_recipe = request.get_json()  # Ambil data dari body request
    if not new_recipe.get('title') or not new_recipe.get('category'):
        return jsonify({"error": "Title and category are required"}), 400
    
    new_recipe['id'] = recipes[-1]['id'] + 1 if recipes else 1
    recipes.append(new_recipe)
    return jsonify(new_recipe), 201

# Route untuk memperbarui resep berdasarkan ID
@app.route('/recipes/<int:id>', methods=['PUT'])
def update_recipe(id):
    recipe = next((r for r in recipes if r['id'] == id), None)
    if recipe is None:
        return jsonify({"error": "Recipe not found"}), 404
    
    updated_data = request.get_json()
    recipe.update(updated_data)
    return jsonify(recipe)

# Route untuk menghapus resep berdasarkan ID
@app.route('/recipes/<int:id>', methods=['DELETE'])
def delete_recipe(id):
    global recipes
    recipes = [r for r in recipes if r['id'] != id]
    return jsonify({"message": f"Recipe with ID {id} deleted"}), 200

if __name__ == '__main__':
    app.run(debug=True)
