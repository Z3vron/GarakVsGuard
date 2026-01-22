import json
import pandas as pd
import ollama
import time
from pathlib import Path

INPUT_DIR = Path("GarakResults")
OUTPUT_DIR = Path("GuardResults")
OUTPUT_DIR.mkdir(exist_ok=True)


def classify_with_llamaguard(text: str) -> tuple[str, str]:
    response = ollama.chat(
        model="llama-guard3",
        messages=[
            {
                "role": "user",
                "content": text
            }
        ],
        options={
            "temperature": 0,
            "num_predict": 256,
            "device": "cpu"  
        }
    )

    output = response["message"]["content"].strip()

    label = "UNKNOWN"
    reason = output

    if "UNSAFE" in output.upper():
        label = "UNSAFE"
    elif "SAFE" in output.upper():
        label = "SAFE"

    return label, reason[:500]  # limit size



for model_dir in INPUT_DIR.iterdir():
    if not model_dir.is_dir():
        continue

    model_name = model_dir.name
    print(f"\n🤖 Model: {model_name}")

    model_output_dir = OUTPUT_DIR / model_name
    model_output_dir.mkdir(exist_ok=True)

    for input_file in model_dir.glob("*.report.jsonl"):
        print(f"\n📂 Processing: {input_file.name}")

        base_name = input_file.name.replace(".report.jsonl", "")
        output_file = model_output_dir  / f"{base_name}.xlsx"

        rows = []

    with open(input_file, "r", encoding="utf-8") as f:
        for line_no, line in enumerate(f, 1):
            entry = json.loads(line)

            if entry.get("entry_type") != "attempt":
                continue

            uuid = entry.get("uuid")
            probe = entry.get("probe_classname")
            goal = entry.get("goal", "")

            try:
                prompt = entry["prompt"]["turns"][0]["content"]["text"]
            except Exception:
                prompt = ""

            outputs = entry.get("outputs", [])
            if not outputs:
                continue

            for idx, output in enumerate(outputs):
                model_output = output.get("text", "").strip()
                if not model_output:
                    continue

                print(f"\n[{line_no}] Classifying {uuid} output {idx+1}/{len(outputs)}")

                try:
                    label, reason = classify_with_llamaguard(model_output)
                except Exception as e:
                    print("   ❌ llama-guard failed:", e)
                    label, reason = "ERROR", str(e)

                rows.append({
                    "uuid": uuid,
                    "probe": probe,
                    "goal": goal,
                    "prompt": prompt,
                    "model_output": model_output,
                    "llama_guard_label": label,
                    "llama_guard_reason": reason
                })


    if rows:
            df = pd.DataFrame(rows)
            df.to_excel(output_file, index=False)
            print(f"   ✅ Saved: {output_file}")
    else:
        print("   ⚠️ No valid attempts found")
