# raycast-privacy-filter

A [Raycast](https://www.raycast.com/) script that anonymizes the text in your clipboard using [OpenAI Privacy Filter](https://github.com/openai/privacy-filter) — a local 1.5B-parameter model for detecting and masking personal data (PII).

The model runs **entirely locally**, without sending data to any external server.

---

## How it works

1. Copy some text to the clipboard
2. Run the script from Raycast
3. The script automatically detects names, addresses, emails, phone numbers, dates, URLs, and other sensitive data
4. It returns the anonymized text and copies it back to the clipboard

### Detected PII categories

| Category | Example |
|---|---|
| `private_person` | Mario Rossi |
| `private_address` | Via Roma 12, Milano |
| `private_email` | mario@esempio.it |
| `private_phone` | +39 333 1234567 |
| `private_date` | 01/01/1990 |
| `private_url` | https://profilo.esempio.com/mario |
| `account_number` | IT60X0542811101000000123456 |
| `secret` | passwords, tokens, API keys |

---

## Requirements

- macOS with [Raycast](https://www.raycast.com/) installed
- Python 3.8+
- ~3 GB of free disk space (for the model, downloaded automatically on first run)

---

## Installation

### 1. Clone the repo into your Raycast scripts folder

Open Raycast → `Extensions` → `Script Commands` → note your scripts folder, then:

```bash
cd /path/to/your/raycast-scripts-folder
git clone https://github.com/YOUR_USERNAME/raycast-privacy-filter
cd raycast-privacy-filter
```

### 2. Install OpenAI Privacy Filter

Choose one of the following methods:

#### Option A — Virtual environment (recommended)

Isolates the dependencies inside the script folder, without touching the system Python:

```bash
python3 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install git+https://github.com/openai/privacy-filter
```

The script automatically detects `.venv/bin/opf` if present.

#### Option B — System Python

```bash
pip3 install git+https://github.com/openai/privacy-filter
```

The script automatically falls back to `opf` in the PATH if no `.venv` is found.

#### Option C — Homebrew Python

If you use Python installed via Homebrew:

```bash
/opt/homebrew/bin/pip3 install git+https://github.com/openai/privacy-filter
```

### 3. Make the script executable

```bash
chmod +x anonymize-clipboard.sh
```

### 4. Add the script to Raycast

If you cloned the repo inside your existing Raycast scripts folder, Raycast will detect it automatically. Otherwise:

- Raycast → `Extensions` → `Script Commands` → `Add Script Directory` → select the `raycast-privacy-filter` folder

### 5. First run

On first use, the model (~3 GB) is automatically downloaded to `~/.opf/privacy_filter`. This may take a few minutes. Subsequent runs will be instant.

---

## Usage

1. Select and copy some text (`⌘ C`)
2. Open Raycast (`⌥ Space`) and search for **"Anonymize text"**
3. Press `↵`

The output shows the original text and the anonymized one. The anonymized text is automatically copied to the clipboard.

Alternatively, you can assign a hotkey to trigger the script directly:
1. Open Raycast (`⌥ Space`)
2. Open the settings `⌘ ⇧ ,` (Cmd + Shift + ,)
3. Search for **"Anonymize text"** and assign it a shortcut
4. Use it with `⌘ C` followed immediately by the shortcut

### Example

**Input (in the clipboard):**
```
Gentile Mario Rossi,
la sua visita è confermata per il 15 marzo 1990.
Può contattarci al +39 02 1234567 o via email a mario.rossi@email.it.
```

**Output:**
```
Gentile [REDACTED],
la sua visita è confermata per il [REDACTED].
Può contattarci al [REDACTED] o via email a [REDACTED].
```

---

## Notes

- The script uses `--device cpu` for maximum compatibility on Mac. If you have a supported GPU, you can remove that flag for better performance.
- The model is primarily optimized for English text. Performance on Italian and other languages is good but may vary.
- Privacy Filter is a supporting tool, not a guarantee of complete anonymization. For high-risk contexts (medical, legal, financial), human review is recommended.

---

## License

MIT — see [LICENSE](LICENSE)

OpenAI Privacy Filter is released under the [Apache 2.0](https://github.com/openai/privacy-filter/blob/main/LICENSE) license.
