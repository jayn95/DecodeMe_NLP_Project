from flask import Flask, request, jsonify, render_template
import pandas as pd
import os
import joblib
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import re, string
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer

# Initialize app
app = Flask(__name__)

# Load model and vectorizer

# Get the directory of the current script (app.py)
base_dir = os.path.dirname(__file__)

# Build absolute paths
model_path = os.path.join(base_dir, 'model', 'naive_bayes.pkl')
vectorizer_path = os.path.join(base_dir, 'model', 'vectorizer.pkl')
label_encoder_path = os.path.join(base_dir, 'model', 'label_encoder.pkl')
df_path = os.path.join(base_dir, 'data', 'ict_subfields_dataset.csv')

# Load the model and vectorizer
model = joblib.load(model_path)
vectorizer = joblib.load(vectorizer_path)
label_encoder = joblib.load(label_encoder_path)
df = pd.read_csv(df_path)

# Ensure dataset is preprocessed
lemmatizer = WordNetLemmatizer()
stop_words = set(stopwords.words('english'))

def preprocess_text(text):
    text = text.lower()
    text = text.translate(str.maketrans('', '', string.punctuation))
    text = re.sub(r'\s+', ' ', text).strip()
    words = [word for word in text.split() if word not in stop_words]
    words = [lemmatizer.lemmatize(word) for word in words]
    return ' '.join(words)

# Add Processed_Text column if not present
if 'Processed_Text' not in df.columns:
    df['Processed_Text'] = df['Text'].apply(preprocess_text)

# Main route for API
@app.route('/predict', methods=['POST'])
def predict():
    user_input = request.json.get("text")
    if not user_input:
        return jsonify({"error": "No input provided"}), 400

    # Preprocess and vectorize user input
    processed = preprocess_text(user_input)
    user_vec = vectorizer.transform([processed])
    dataset_vecs = vectorizer.transform(df['Processed_Text'])

    # Cosine similarity
    similarity = cosine_similarity(user_vec, dataset_vecs)
    top_index = np.argmax(similarity)

    subfield = df['Subfield'].iloc[top_index]
    job = df['Job Title'].iloc[top_index]

    return jsonify({
        "subfield": subfield,
        "recommended_job": job
    })

# (Optional) Route to frontend HTML
@app.route('/')
def home():
    return render_template('index.html')

# Run the app
if __name__ == '__main__':
    app.run(debug=True)
