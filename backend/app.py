from flask import Flask, request, jsonify, render_template
import pandas as pd
import os
import joblib
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import re, string
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from flask_cors import CORS

# Set up a specific directory for nltk_data
nltk_data_path = os.path.join(os.path.dirname(__file__), 'nltk_data')
nltk.data.path.append(nltk_data_path)

# Initialize app
app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

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
    # Expect a JSON with 3 answers
    answers = request.json.get("answers")
    if not answers or not isinstance(answers, list) or len(answers) != 3:
        return jsonify({"error": "Please provide answers to all 3 questions."}), 400

    dataset_vecs = vectorizer.transform(df['Processed_Text'])
    predictions = []
    similarities = []
    processed_answers = []

    for answer in answers:
        processed = preprocess_text(answer)
        processed_answers.append(processed)
        user_vec = vectorizer.transform([processed])
        similarity = cosine_similarity(user_vec, dataset_vecs)
        top_index = np.argmax(similarity)
        predictions.append(df['Subfield'].iloc[top_index])
        similarities.append(similarity[0][top_index])

    # Determine final subfield - majority vote or highest similarity
    # Option 1: Majority vote
    from collections import Counter
    subfield_count = Counter(predictions)
    final_subfield = subfield_count.most_common(1)[0][0]

    # Option 2: If tie or just to be sure, pick the prediction with highest similarity
    # Uncomment below if you want to use this instead:
    # max_sim_index = np.argmax(similarities)
    # final_subfield = predictions[max_sim_index]

    # Get recommended job(s) for final_subfield
    # For simplicity, pick first matching job in df for that subfield
    final_jobs = df[df['Subfield'] == final_subfield]['Job Title'].unique()
    recommended_job = final_jobs[0] if len(final_jobs) > 0 else "No job found"

    return jsonify({
        "final_subfield": final_subfield,
        "recommended_job": recommended_job,
        "individual_predictions": predictions,
        "processed_answers": processed_answers
    })

from flask import send_from_directory

@app.route('/')
def serve_flutter_app():
    return send_from_directory('../frontend/build/web', 'index.html')

@app.route('/<path:path>')
def serve_static_file(path):
    return send_from_directory('../frontend/build/web', path)

# Run the app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)