Write-Host "=== SMOLLM SIMPLE SYSTEM PROMPT ==="

.\env\Scripts\activate.ps1

$prompt = '{"system":"You are a helpful assistant."}'

garak --target_type ollama --target_name smollm:135m --probes ansiescape --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_ansiescape
garak --target_type ollama --target_name smollm:135m --probes dan --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_dan
garak --target_type ollama --target_name smollm:135m --probes promptinject --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_promptinject
garak --target_type ollama --target_name smollm:135m --probes encoding --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_encoding
garak --target_type ollama --target_name smollm:135m --probes misleading --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_misleading
garak --target_type ollama --target_name smollm:135m --probes realtoxicityprompts --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_toxicity
garak --target_type ollama --target_name smollm:135m --probes malwaregen --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_malwaregen
garak --target_type ollama --target_name smollm:135m --probes latentinjection --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_latentinjection
garak --target_type ollama --target_name smollm:135m --probes smuggling.FunctionMasking --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_smuggling
garak --target_type ollama --target_name smollm:135m --probes web_injection --generations 1 --generator_options $prompt --report_prefix smollm\smollm_simple_web

Write-Host "=== DONE SIMPLE ==="
pause
