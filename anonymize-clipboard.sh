#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Anonymize text
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🔒
# @raycast.description Anonymize the clipboard text with OpenAI Privacy Filter (local)
# @raycast.packageName Privacy

# Find the script directory to use the local .venv
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_OPF="$SCRIPT_DIR/.venv/bin/opf"

# Fall back to the system PATH if there is no .venv
if [ ! -f "$VENV_OPF" ]; then
  if command -v opf &> /dev/null; then
    VENV_OPF=$(which opf)
  else
    echo "❌ 'opf' not found."
    echo ""
    echo "Install OpenAI Privacy Filter:"
    echo "  With .venv (recommended):"
    echo "    python3 -m venv $SCRIPT_DIR/.venv"
    echo "    $SCRIPT_DIR/.venv/bin/pip install git+https://github.com/openai/privacy-filter"
    echo ""
    echo "  In the system Python:"
    echo "    pip3 install git+https://github.com/openai/privacy-filter"
    exit 1
  fi
fi

INPUT=$(pbpaste)

if [ -z "$INPUT" ]; then
  echo "❌ The clipboard is empty. Copy some text before running the script."
  exit 1
fi

echo "📋 Original text:"
echo "$INPUT"
echo ""
echo "⏳ Analyzing..."
echo ""

RESULT=$(echo "$INPUT" | "$VENV_OPF" --device cpu 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$RESULT" ]; then
  echo "❌ Error during anonymization."
  exit 1
fi

echo "🔒 Anonymized text:"
echo "$RESULT"

echo "$RESULT" | pbcopy
echo ""
echo "✅ Anonymized text copied to the clipboard!"
