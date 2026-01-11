import json
from bs4 import BeautifulSoup
import requests

def extract_next_data(html):
    soup = BeautifulSoup(html, "html.parser")
    script = soup.find("script", id="__NEXT_DATA__")
    if not script:
        raise RuntimeError("__NEXT_DATA__ not found")
    return json.loads(script.string)


def get_subcategories(category_url):
    import re

    html = requests.get(category_url, timeout=20).text
    # data = extract_next_data(html)

    subcats = []
    # exctract subcategory link - /en/vocab/subcategory/(\d+))/learn
    subcat_link = re.search(r"/en/vocab/subcategory/(\d+)/learn", html)
    if subcat_link:
        subcats.append('https://langeek.co' + subcat_link)
    else:
        raise ValueError("Subcategory link not found")

    return subcats

C2_URL = "https://langeek.co/en/vocab/category/251/c2-level"
C1_URL = "https://langeek.co/en/vocab/category/35/c1-level"


def get_words_from_subcategory(url):
    html = requests.get(url, timeout=20).text
    data = extract_next_data(html)

    words = []

    vocab_items = (
        data["props"]["pageProps"]
        .get("lesson", {})
        .get("vocabularies", [])
    )

    for v in vocab_items:
        words.append({
            "word": v.get("word"),
            "meaning": v.get("definition"),
            "pos": v.get("partOfSpeech"),
        })

    return words


def extract_level(level="C2"):
    if level == "C2":
        url = "https://langeek.co/en/vocab/category/251/c2-level"
    elif level == "C1":
        url = "https://langeek.co/en/vocab/category/250/c1-level"
    else:
        raise ValueError("Only C1 or C2 supported")

    print(f"Getting subcategories for {level}")
    subcats = get_subcategories(url)

    all_words = []
    for sc in subcats:
        print(f"Getting words from subcategory {sc}")
        words = get_words_from_subcategory(sc)
        for w in words:
            w["cefr"] = level
        all_words.extend(words)

    print(f"Saved {len(all_words)} words to cfr_{level}.json")
    with open(f"cfr_{level}.json", "w") as f:
        json.dump(all_words, f, indent=4)


if __name__ == "__main__":
    extract_level("C1")
    # extract_level("C2")
    print("Done")

