from sentence_transformers import SentenceTransformer
from sklearn.cluster import DBSCAN
from sklearn.metrics.pairwise import cosine_distances
from razdel import sentenize # работа с кириллицей
import re # регулярные выражения
import subprocess # для открытия файла в текстовом редакторе

# === НАСТРОЙКИ

# чувствительность кластеризации
    # Если предложений (кластеров) слишком много, eps можно увеличить.
    # Если кластеров мало — eps можно уменьшить, например, 0,25 или 0.22.
eps_val = 0.34

inputFile = "/home/astenix/workspace/SentenceTransformer/input.txt"
tempFile = "/tmp/SentenceTransformer.txt"
outputFile = "/home/astenix/workspace/SentenceTransformer/output.txt"

import nltk
    # каталог, в котором надо искать tokenizers/punkt
nltk.data.path.append('/home/astenix/workspace/LLMs')
    # скачать токенизатор punkt, если его нет; иначе go дальше
try:
    nltk.data.find('/home/astenix/workspace/LLMs/tokenizers/punkt')
except LookupError:
    nltk.download(nltk.download('punkt', download_dir='/home/astenix/workspace/LLMs'))

# === ВЫПОЛНЕНИЕ

# === 1. Загружаем модель ===
print("\n1. Загружаем модель")

model = SentenceTransformer("sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2")

# === 2. Читаем текст ===
print("2. Читаем текст")

with open(inputFile, "r", encoding="utf-8") as f:
    text = f.read()

# === 3. Разбиваем текст на предложения с помощью razdel ===
print("3. Разбиваем текст на предложения")

sentences = [s.text for s in sentenize(text)]

# === 4. Векторизуем предложения ===
print("4. Векторизуем предложения")

embeddings = model.encode(sentences)

# === 5. Кластеризация DBSCAN с косинусным расстоянием ===
print("5. Кластеризация DBSCAN с косинусным расстоянием")

dist_matrix = cosine_distances(embeddings)
db = DBSCAN(eps=eps_val, min_samples=2, metric='precomputed')
labels = db.fit_predict(dist_matrix)

#print("\n\tКоличество кластеров (без шума):", len(set(labels)) - (1 if -1 in labels else 0))
#print("\n\tМетки кластеров:", set(labels))

#from collections import Counter
#print("\n\tРаспределение по кластерам:", Counter(labels))

# === 6. Группируем предложения по кластерам, шум (-1) делаем отдельными абзацами ===
print("6. Группируем предложения по кластерам, делаем отдельные абзацы")

paragraphs = {}
max_label = max(labels)
for idx, label in enumerate(labels):
    if label == -1:
        # Для шума создаём уникальный новый кластер, чтобы не объединять
        label = max_label + 1 + idx
    paragraphs.setdefault(label, []).append(sentences[idx])

# === 7. Сортируем абзацы по позиции первого предложения в тексте ===
print("7. Сортируем абзацы по позиции первого предложения в тексте")

sentence_pos = {s: i for i, s in enumerate(sentences)}
ordered_keys = sorted(paragraphs.keys(), key=lambda k: sentence_pos[paragraphs[k][0]])
ordered_paragraphs = [paragraphs[k] for k in ordered_keys]

# === 8. Записываем результат в файл с пустой строкой между абзацами ===
    # Удалить пустые строки.
    # Учесть заголовки (==)
    # Склеить соседние непустые строки, вставляя между ними \n, чтобы они не сливались в одну строку.
    # Сохранить результат в файл output.txt
print("8. Записываем результат в файл temp.txt")

with open(tempFile, "w", encoding="utf-8") as f:
    for para in ordered_paragraphs:
        clean_para = [s.replace('\n', ' ').strip() for s in para]
        f.write(" ".join(clean_para).strip() + "\n\n")

# === 9. Окончательно форматируем текст для output.txt
print("9. Окончательно форматируем текст для output.txt")

with open(tempFile, "r", encoding="utf-8") as f:
    lines = f.readlines()

result = []
for line in lines:
    stripped = line.strip()

    # Пустая строка — сохраняем как есть
    if stripped == "":
        result.append("")
        continue

    # Найдём все заголовки внутри строки и разобьём
    parts = re.split(r"(=+[^=].*?=+)", stripped)
    for part in parts:
        part = part.strip()
        if not part:
            continue
        if re.fullmatch(r"=+[^=].*?=+", part):
            result.append("")
            result.append(part)
            result.append("")
        else:
            # Текст не заголовок — добавляем как есть
            result.append(part)

with open(outputFile, "w", encoding="utf-8") as f:
    f.write("\n".join(result))


# === 10 Открываем файл output.txt в текстовом редакторе
print("10. Открываем файл output.txt в текстовом редакторе")

subprocess.run(["/opt/sublime_text/sublime_text", outputFile])

print(" ")
