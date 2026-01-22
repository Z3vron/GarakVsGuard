Write-Host "=== MISTRAL BASELINE (no system prompt) ==="

.\env\Scripts\activate.ps1
garak --target_type ollama --target_name mistral --probes encoding --generations 1 --report_prefix mistral\mistral_baseline_encoding
garak --target_type ollama --target_name mistral --probes misleading --generations 1 --report_prefix mistral\mistral_baseline_misleading
garak --target_type ollama --target_name mistral --probes realtoxicityprompts --generations 1 --report_prefix mistral\mistral_baseline_toxicity
garak --target_type ollama --target_name mistral --probes malwaregen --generations 1 --report_prefix mistral\mistral_baseline_malwaregen
garak --target_type ollama --target_name mistral --probes latentinjection --generations 1 --report_prefix mistral\mistral_baseline_latentinjection
garak --target_type ollama --target_name mistral --probes smuggling.FunctionMasking --generations 1 --report_prefix mistral\mistral_baseline_smuggling
garak --target_type ollama --target_name mistral --probes web_injection --generations 1 --report_prefix mistral\mistral_baseline_web

Write-Host "=== DONE BASELINE ==="
pause
