from flask import request, render_template
from app import app
from models import Post


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        text = request.form['text']
        post = Post(text=text).save()

    posts = Post.objects.all()
    return render_template('index.html', posts=posts)