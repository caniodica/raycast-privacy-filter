#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Anonimizza testo
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🔒
# @raycast.description Anonimizza il testo negli appunti con OpenAI Privacy Filter (locale)
# @raycast.packageName Privacy

# Trova la directory dello script per usare il .venv locale
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_OPF="$SCRIPT_DIR/.venv/bin/opf"

# Fallback al PATH di sistema se non c'è il .venv
if [ ! -f "$VENV_OPF" ]; then
  if command -v opf &> /dev/null; then
    VENV_OPF=$(which opf)
  else
    echo "❌ 'opf' non trovato."
    echo ""
    echo "Installa OpenAI Privacy Filter:"
    echo "  Con .venv (consigliato):"
    echo "    python3 -m venv $SCRIPT_DIR/.venv"
    echo "    $SCRIPT_DIR/.venv/bin/pip install git+https://github.com/openai/privacy-filter"
    echo ""
    echo "  Nel Python di sistema:"
    echo "    pip3 install git+https://github.com/openai/privacy-filter"
    exit 1
  fi
fi

INPUT=$(pbpaste)

if [ -z "$INPUT" ]; then
  echo "❌ Gli appunti sono vuoti. Copia del testo prima di eseguire lo script."
  exit 1
fi

echo "📋 Testo originale:"
echo "$INPUT"
echo ""
echo "⏳ Analisi in corso..."
echo ""

RESULT=$(echo "$INPUT" | "$VENV_OPF" --device cpu 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$RESULT" ]; then
  echo "❌ Errore durante l'anonimizzazione."
  exit 1
fi

echo "🔒 Testo anonimizzato:"
echo "$RESULT"

echo "$RESULT" | pbcopy
echo ""
echo "✅ Testo anonimizzato copiato negli appunti!"
