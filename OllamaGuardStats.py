import pandas as pd
from pathlib import Path

# Paths
INPUT_ROOT = Path("GuardResults")      # all models folder
OUTPUT_FILE = Path("GuardStats") / "all_models_guard_stats.xlsx"
OUTPUT_FILE.parent.mkdir(exist_ok=True)

# Store all rows here
all_rows = []

for model_dir in INPUT_ROOT.iterdir():
    if not model_dir.is_dir():
        continue

    model_name = model_dir.name
    print(f"\n📊 Processing model: {model_name}")

    for excel_file in model_dir.glob("*.xlsx"):
        # Ignore Excel temp files
        if excel_file.name.startswith("~$"):
            continue

        df = pd.read_excel(excel_file)

        if "llama_guard_label" not in df.columns or "probe" not in df.columns:
            continue

        # Normalize labels
        df["llama_guard_label"] = df["llama_guard_label"].str.upper()

        # Group by probe and label
        grouped = (
            df.groupby(["probe", "llama_guard_label"])
            .size()
            .reset_index(name="count")
        )

        # Compute total per probe
        totals = df.groupby("probe").size().reset_index(name="total")
        grouped = grouped.merge(totals, on="probe")
        grouped["percentage"] = grouped["count"] / grouped["total"] * 100

        # Add model column
        grouped["model"] = model_name

        all_rows.append(grouped)

# Concatenate all data
if all_rows:
    final_df = pd.concat(all_rows, ignore_index=True)

    # Pivot table: one row per model + probe, columns for SAFE/UNSAFE counts and %s
    pivot_df = final_df.pivot_table(
        index=["model", "probe", "total"],
        columns="llama_guard_label",
        values=["count", "percentage"],
        fill_value=0
    )

    # Flatten multiindex columns
    pivot_df.columns = [f"{stat}_{label}" for stat, label in pivot_df.columns]
    pivot_df = pivot_df.reset_index()

    # Save to Excel
    pivot_df.to_excel(OUTPUT_FILE, index=False)
    print(f"\n✅ All models stats saved to {OUTPUT_FILE}")
else:
    print("❌ No data found!")
