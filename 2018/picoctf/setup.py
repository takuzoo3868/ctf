#!/usr/bin/env python
import os, json, itertools
import html2text
from jinja2 import Template

open_json = open("problems.json").read()
load_json = json.loads(open_json)
data_json = load_json["data"]

template = open("template.md").read()
writeup = Template(template)

# カテゴリ分けした問題用ディレクトリとwriteupテンプレ作成
for problem in data_json:
    # 空白の置換処理
    catg_src = str(problem["category"])
    catg_dst = catg_src.replace(" ", "_")
    name_src = str(problem["name"])
    name_dst = name_src.replace(" ", "_")

    if not os.path.exists("{}/{}".format(catg_dst, name_dst)):
        os.makedirs("{}/{}".format(catg_dst, name_dst), exist_ok=True)

    # problem.jsonから問題文を抽出
    desc = problem["description"]
    # 問題文を整形
    problem["description"] = html2text.html2text(desc).replace("\n", "")
    # 辞書を指定して文字列の埋め込み
    rendered = writeup.render(problem=problem)
    # 各writeupを作成
    path = "{}/{}/README.md".format(catg_dst, name_dst)
    with open(path, "wb") as f:
        f.write(rendered.encode("utf-8"))
        f.close()

    # READMEへ問題一覧を作成
    with open("README.md", "a") as problem_list:
        if problem["solved"] == True:
            problem_list.write(
                "[{}](./{}/{}) | {} | {} | \n".format(
                    problem["name"],
                    catg_dst,
                    name_dst,
                    problem["category"],
                    problem["score"],
                )
            )
        problem_list.close()
