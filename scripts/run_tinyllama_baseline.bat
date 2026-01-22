@echo off
echo === TinyLlama BASELINE (no system prompt) ===
call env\Scripts\activate.bat
garak --target_type ollama --target_name tinyllama --probes ansiescape --generations 1 --report_prefix tinyllama\tinyllama_ansiescape
garak --target_type ollama --target_name tinyllama --probes dan --generations 1 --report_prefix tinyllama\tinyllama_dan
garak --target_type ollama --target_name tinyllama --probes promptinject --generations 1 --report_prefix tinyllama\tinyllama_promptinject
garak --target_type ollama --target_name tinyllama --probes encoding --generations 1 --report_prefix tinyllama\tinyllama_encoding
garak --target_type ollama --target_name tinyllama --probes misleading --generations 1 --report_prefix tinyllama\tinyllama_misleading
garak --target_type ollama --target_name tinyllama --probes realtoxicityprompts --generations 1 --report_prefix tinyllama\tinyllama_toxicity
garak --target_type ollama --target_name tinyllama --probes malwaregen --generations 1 --report_prefix tinyllama\tinyllama_malwaregen
garak --target_type ollama --target_name tinyllama --probes latentinjection --generations 1 --report_prefix tinyllama\tinyllama_latentinjection
garak --target_type ollama --target_name tinyllama --probes smuggling.FunctionMasking --generations 1 --report_prefix tinyllama\tinyllama_smuggling
garak --target_type ollama --target_name tinyllama --probes web_injection --generations 1 --report_prefix tinyllama\tinyllama_web

echo === DONE: BASELINE ===
pause
