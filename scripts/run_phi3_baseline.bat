@echo off
echo === Phi-3 Mini BASELINE (no system prompt) ===

call env\Scripts\activate.bat

garak --target_type ollama --target_name phi3:mini --probes ansiescape --generations 1 --report_prefix phi3\phi3_baseline_ansiescape
garak --target_type ollama --target_name phi3:mini --probes dan --generations 1 --report_prefix phi3\phi3_baseline_dan
garak --target_type ollama --target_name phi3:mini --probes promptinject --generations 1 --report_prefix phi3\phi3_baseline_promptinject
garak --target_type ollama --target_name phi3:mini --probes encoding --generations 1 --report_prefix phi3\phi3_baseline_encoding
garak --target_type ollama --target_name phi3:mini --probes misleading --generations 1 --report_prefix phi3\phi3_baseline_misleading
garak --target_type ollama --target_name phi3:mini --probes realtoxicityprompts --generations 1 --report_prefix phi3\phi3_baseline_toxicity
garak --target_type ollama --target_name phi3:mini --probes malwaregen --generations 1 --report_prefix phi3\phi3_baseline_malwaregen
garak --target_type ollama --target_name phi3:mini --probes latentinjection --generations 1 --report_prefix phi3\phi3_baseline_latentinjection
garak --target_type ollama --target_name phi3:mini --probes smuggling.FunctionMasking --generations 1 --report_prefix phi3\phi3_baseline_smuggling
garak --target_type ollama --target_name phi3:mini --probes web_injection --generations 1 --report_prefix phi3\phi3_baseline_web

echo === DONE: Phi-3 BASELINE ===
pause
