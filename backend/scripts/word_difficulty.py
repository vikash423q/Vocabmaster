import nltk
nltk.download('wordnet')

from nltk.corpus import wordnet as wn
from wordfreq import zipf_frequency


CEFR_SCORES = {
    "A1": 0,
    "A2": 10,
    "B1": 30,
    "B2": 60,
    "C1": 80,
    "C2": 100
}

def polysemy_score(word):
    return min(len(wn.synsets(word)) * 12.5, 100)

def zipf_score(zipf):
    """
    Lower frequency = harder
    Zipf 7 → 0
    score 1 → 100
    """
    return (7-zipf)/7 * 100


def difficulty_label(score):
    # labels = [
    #     "Ultra Easy",
    #     "Very Easy",
    #     "Easy",
    #     "Lower Medium",
    #     "Medium",
    #     "Upper Medium",
    #     "Hard",
    #     "Very Hard",
    #     "Rare / Obscure"
    # ]
    score_buckets = [
        (1, 10, "Ultra Easy"),
        (2, 20, "Very Easy"),
        (3, 30, "Easy"),
        (4, 40, "Lower Medium"),
        (5, 55, "Medium"),
        (6, 70, "Upper Medium"),
        (7, 80, "Hard"),
        (8, 90, "Very Hard"),
        (9, 100, "Rare / Obscure")
    ]
    for level, threshold, label in score_buckets:
        if score < threshold:
            return level, label
    return 10, "Rare / Obscure"

def get_difficulty_score(word, cefr):
    zipf = zipf_frequency(word, 'en')
    cefr_score = CEFR_SCORES.get(cefr, CEFR_SCORES["B2"])
    score = 0.5*zipf_score(zipf) + 0.5*cefr_score + 0.1*polysemy_score(word)
    return round(min(score, 100), 1)


def test_words():
    words = [
        ("leavening", "C2"),
        ("burgeoning", "C2"),
        ("maelstrom", "C2"),
        ("scornful", "C1"),
        ("evoke", "C1"),
        ("exodus", "C1"),
        ("paralyze", "B1"),
    ]

    for word, cefr in words:
        score = get_difficulty_score(word, cefr)
        print(f"{word} ({cefr}): {score} ({difficulty_label(score)})")

if __name__ == "__main__":
    test_words()