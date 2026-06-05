# raycast-privacy-filter

Uno script [Raycast](https://www.raycast.com/) che anonimizza il testo negli appunti usando [OpenAI Privacy Filter](https://github.com/openai/privacy-filter) — un modello locale da 1.5B parametri per il rilevamento e la mascheratura di dati personali (PII).

Il modello gira **interamente in locale**, senza inviare dati a nessun server esterno.

---

## Come funziona

1. Copi del testo negli appunti
2. Lanci lo script da Raycast
3. Lo script rileva automaticamente nomi, indirizzi, email, telefoni, date, URL e altri dati sensibili
4. Restituisce il testo anonimizzato e lo ricopia negli appunti

### Categorie di PII rilevate

| Categoria | Esempio |
|---|---|
| `private_person` | Mario Rossi |
| `private_address` | Via Roma 12, Milano |
| `private_email` | mario@esempio.it |
| `private_phone` | +39 333 1234567 |
| `private_date` | 01/01/1990 |
| `private_url` | https://profilo.esempio.com/mario |
| `account_number` | IT60X0542811101000000123456 |
| `secret` | password, token, chiavi API |

---

## Requisiti

- macOS con [Raycast](https://www.raycast.com/) installato
- Python 3.8+
- ~3 GB di spazio libero (per il modello, scaricato automaticamente al primo avvio)

---

## Installazione

### 1. Clona la repo nella cartella degli script Raycast

Apri Raycast → `Extensions` → `Script Commands` → annota la tua cartella degli script, poi:

```bash
cd /path/alla/tua/cartella-script-raycast
git clone https://github.com/TUO_USERNAME/raycast-privacy-filter
cd raycast-privacy-filter
```

### 2. Installa OpenAI Privacy Filter

Scegli uno dei metodi:

#### Opzione A — Virtual environment (consigliato)

Isola le dipendenze nella cartella dello script, senza toccare il Python di sistema:

```bash
python3 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install git+https://github.com/openai/privacy-filter
```

Lo script rileva automaticamente `.venv/bin/opf` se presente.

#### Opzione B — Python di sistema

```bash
pip3 install git+https://github.com/openai/privacy-filter
```

Lo script fa automaticamente il fallback a `opf` nel PATH se non trova il `.venv`.

#### Opzione C — Homebrew Python

Se usi Python installato via Homebrew:

```bash
/opt/homebrew/bin/pip3 install git+https://github.com/openai/privacy-filter
```

### 3. Rendi lo script eseguibile

```bash
chmod +x anonymize-clipboard.sh
```

### 4. Aggiungi lo script a Raycast

Se hai clonato la repo dentro la cartella degli script Raycast esistente, Raycast la rileverà automaticamente. Altrimenti:

- Raycast → `Extensions` → `Script Commands` → `Add Script Directory` → seleziona la cartella `raycast-privacy-filter`

### 5. Primo avvio

Al primo utilizzo, il modello (~3 GB) viene scaricato automaticamente in `~/.opf/privacy_filter`. Potrebbero volerci alcuni minuti. Le esecuzioni successive saranno immediate.

---

## Utilizzo

1. Seleziona e copia del testo (`⌘C`)
2. Apri Raycast (`⌥Space`) e cerca **"Anonimizza testo"**
3. Premi `↵`

L'output mostra il testo originale e quello anonimizzato. Il testo anonimizzato viene automaticamente copiato negli appunti.

### Esempio

**Input (negli appunti):**
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

## Note

- Lo script usa `--device cpu` per compatibilità massima su Mac. Se hai una GPU supportata, puoi rimuovere quel flag per maggiore velocità.
- Il modello è ottimizzato principalmente per testo in inglese. Le performance su italiano e altre lingue sono buone ma possono variare.
- Privacy Filter è uno strumento di supporto, non una garanzia di anonimizzazione completa. Per contesti ad alto rischio (medico, legale, finanziario), è consigliata una revisione umana.

---

## Licenza

MIT — vedi [LICENSE](LICENSE)

OpenAI Privacy Filter è rilasciato sotto licenza [Apache 2.0](https://github.com/openai/privacy-filter/blob/main/LICENSE).
