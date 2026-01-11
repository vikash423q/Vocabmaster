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
    num_of_synsets = len(wn.synsets(word))
    if num_of_synsets > 1:
        score = 0.4*zipf_score(zipf) + 0.3*cefr_score + min(10*num_of_synsets, 30)
    else:
        score = 0.5*zipf_score(zipf) + 0.4*cefr_score + 10
    
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
        ("moment", "A1"),
        ("table", "A1"),
        ("dog", "A1"),
        ("bank", "A2")
    ]

    for word, cefr in words:
        score = get_difficulty_score(word, cefr)
        print(f"{word} ({cefr}): {score} ({difficulty_label(score)})")

if __name__ == "__main__":
    import math
    from update_seed_data_with_cefr import load_cefr_csv, CEFR_CSV_FILE
    cefr_map = load_cefr_csv(CEFR_CSV_FILE)

    b2_scores = []
    b1_scores = []
    b2_synsets = []
    b1_synsets = []
    c1_scores = []
    c2_scores = []
    c1_synsets = []
    c2_synsets = []
    for word, cefr in cefr_map.items():
        if cefr == "B2":
            b2_scores.append(zipf_score(zipf_frequency(word, 'en')))
            b2_synsets.append(len(wn.synsets(word)))
        elif cefr == "B1":
            b1_scores.append(zipf_score(zipf_frequency(word, 'en')))
            b1_synsets.append(len(wn.synsets(word)))
        elif cefr == "C1":
            c1_scores.append(zipf_score(zipf_frequency(word, 'en')))
            c1_synsets.append(len(wn.synsets(word)))
        elif cefr == "C2":
            c2_scores.append(zipf_score(zipf_frequency(word, 'en')))
            c2_synsets.append(len(wn.synsets(word)))
    
    print(f"B2 scores: {sum(b2_scores)/len(b2_scores)}, {min(b2_scores)}, {max(b2_scores)}, {sum(b2_synsets)/len(b2_synsets)}, {min(b2_synsets)}, {max(b2_synsets)}")
    print(f"B1 scores: {sum(b1_scores)/len(b1_scores)}, {min(b1_scores)}, {max(b1_scores)}, {sum(b1_synsets)/len(b1_synsets)}, {min(b1_synsets)}, {max(b1_synsets)}")
    print(f"C1 scores: {sum(c1_scores)/len(c1_scores)}, {min(c1_scores)}, {max(c1_scores)}, {sum(c1_synsets)/len(c1_synsets)}, {min(c1_synsets)}, {max(c1_synsets)}")
    print(f"C2 scores: {sum(c2_scores)/len(c2_scores)}, {min(c2_scores)}, {max(c2_scores)}, {sum(c2_synsets)/len(c2_synsets)}, {min(c2_synsets)}, {max(c2_synsets)}")

    test_words()