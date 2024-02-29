from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)


# Define a Product class
class Product:
    def __init__(self, id, name):
        self.id = id
        self.name = name


@app.route('/')
def index():
    return 'Welcome to the review application!'

@app.route('/products')
def products():
    # Logic to fetch list of products from the database
    # In this example, we'll create a list of Product objects manually
    products = [Product(id=1, name='ChatGPT'), Product(id=2, name='GEMINI')]
    return render_template('products.html', products=products)

@app.route('/products/<product_id>/reviews')
def get_reviews(product_id):
    # Logic to fetch reviews for a specific product
    reviews = ["Default Review"]  # Fetch reviews from database based on product_id
    return render_template('reviews.html', reviews=reviews)

@app.route('/products/<product_id>/reviews/add', methods=['GET', 'POST'])
def add_review(product_id):
    if request.method == 'POST':
        # Logic to add a review for a specific product
        return redirect(url_for('get_reviews', product_id=product_id))
    return render_template('add_review.html', product_id=product_id)

@app.route('/products/<product_id>/reviews/<review_id>/edit', methods=['GET', 'POST'])
def edit_review(product_id, review_id):
    if request.method == 'POST':
        # Logic to edit a review for a specific product
        return redirect(url_for('get_reviews', product_id=product_id))
    # Fetch review from database and render edit_review.html
    return render_template('edit_review.html', product_id=product_id, review_id=review_id)

@app.route('/products/<product_id>/reviews/<review_id>/delete', methods=['POST'])
def delete_review(product_id, review_id):
    # Logic to delete a review for a specific product
    return redirect(url_for('get_reviews', product_id=product_id))


if __name__ == "__main__":
    app.run(debug=True)
