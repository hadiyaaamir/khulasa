from flask import Flask, request
from flask_cors import CORS, cross_origin
from summa.summarizer import summarize

from sklearn.feature_extraction.text import CountVectorizer
from spacy.lang.ur.stop_words import STOP_WORDS
import pickle
# from collections import Counter
from heapq import nlargest
import spacy

from bs4 import BeautifulSoup
import requests
import re

app = Flask(__name__)
CORS(app, support_credentials=True)


@cross_origin(supports_credentials=True)

@app.route("/api", methods = ['POST'])
def summarise():
    data = {}
    # summary_type = str(request.args['type'])
    # data['type'] = summary_type

    request_data = request.get_json()
    text = request_data['text']
    algo = request_data['algo']
    ratio = request_data['ratio']


    # ratio = request.args.get['ratio']

    if algo == 'summa':

        summary = ext_summary_summa(text,ratio)
    else:
        summary = ext_summary_2(text,ratio)

    data['summary'] = summary

    return data


def ext_summary_summa(text, ratio=0.5):
    summary = summarize(text, ratio=ratio, language="arabic")
    return summary


def ext_summary_2(text, ratio=0.5):
    nlp = spacy.blank('ur')

    doc = nlp(text)
    tokens=[token.text for token in doc]

    punctuation="[:؛؟’‘٭ء،۔]+"

    word_frequencies={}
    for word in doc:
        if word.text.lower() not in STOP_WORDS:
            if word.text.lower() not in punctuation:
                if word.text not in word_frequencies.keys():
                    word_frequencies[word.text] = 1
                else:
                    word_frequencies[word.text] += 1

    max_frequency=max(word_frequencies.values())
    for word in word_frequencies.keys():
        word_frequencies[word]=word_frequencies[word]/max_frequency

    sentences=[]
    sentence=[]
    punc="[:؛’‘٭ء،]+"
    puncc="؟۔"
    for word in text:
        if word not in punc:
            if word in puncc:
                sentence=text.split(word,1)
                sentences.append(sentence[0])
                text=sentence[1]

    sentence_tokens={}
    sentence_scores = {}
    for doc in nlp.pipe(sentences):
        sentence_tokens= (doc)
        # print (sentence_tokens)
        for word in sentence_tokens:
            if word.text.lower() in word_frequencies.keys():
                if sentence_tokens not in sentence_scores.keys():
                    sentence_scores[sentence_tokens]=word_frequencies[word.text.lower()]
                else:
                    sentence_scores[sentence_tokens]+=word_frequencies[word.text.lower()]

    select_length=int(len(sentence_scores)*ratio)

    summary=nlargest(select_length, sentence_scores,key=sentence_scores.get)

    s = ""
    for doc in summary:
        s = s + doc.text
    return s

@app.route("/category", methods = ['POST'])
def category():
    data= {}

    request_data = request.get_json()
    text = request_data['text']

    with open('news_category_classifier_8164_withcv (1).pickle', 'rb') as f:
        cv,labelEnocder_y, classifier = pickle.load(f)

    punctuation="[:؛؟’‘٭ء،۔]+"
    nlp = spacy.blank('ur')

    corpus = []

    review = nlp(text)
    review=review.text.lower()
    review=review.split()
    review = [word for word in review if not word in STOP_WORDS and not word in punctuation]
    review=' '.join(review)
    corpus.append(review)


    x=cv.transform(corpus).toarray()

    y_predicted = classifier.predict(x)

    data['category'] = labelEnocder_y.inverse_transform(y_predicted)[0]


    return data['category']

@app.route("/rssfeed", methods = ['POST'])
def rssfeed():
    return "hello"

if __name__ == "__main__":
    app.run()