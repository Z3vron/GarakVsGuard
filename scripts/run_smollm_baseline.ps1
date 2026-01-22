Write-Host "=== SMOLLM BASELINE (no system prompt) ==="

.\env\Scripts\activate.ps1

garak --target_type ollama --target_name smollm:135m --probes ansiescape --generations 1 --report_prefix smollm\smollm_baseline_ansiescape
garak --target_type ollama --target_name smollm:135m --probes dan --generations 1 --report_prefix smollm\smollm_baseline_dan
garak --target_type ollama --target_name smollm:135m --probes promptinject --generations 1 --report_prefix smollm\smollm_baseline_promptinject
garak --target_type ollama --target_name smollm:135m --probes encoding --generations 1 --report_prefix smollm\smollm_baseline_encoding
garak --target_type ollama --target_name smollm:135m --probes misleading --generations 1 --report_prefix smollm\smollm_baseline_misleading
garak --target_type ollama --target_name smollm:135m --probes realtoxicityprompts --generations 1 --report_prefix smollm\smollm_baseline_toxicity
garak --target_type ollama --target_name smollm:135m --probes malwaregen --generations 1 --report_prefix smollm\smollm_baseline_malwaregen
garak --target_type ollama --target_name smollm:135m --probes latentinjection --generations 1 --report_prefix smollm\smollm_baseline_latentinjection
garak --target_type ollama --target_name smollm:135m --probes smuggling.FunctionMasking --generations 1 --report_prefix smollm\smollm_baseline_smuggling
garak --target_type ollama --target_name smollm:135m --probes web_injection --generations 1 --report_prefix smollm\smollm_baseline_web

Write-Host "=== DONE BASELINE ==="
pause
