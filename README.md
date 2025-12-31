# AI Context Hub

A centralized, versioned repository for official documentation, designed to provide "Source of Truth" context for AI coding assistants like Antigravity.

## 🚀 Usage (For Developers)

To use this context in your project:

### 1. Setup the Hub (Once per machine)

Clone this repository to a standard location on your machine:

```bash
mkdir -p ~/dev
git clone https://github.com/YOUR_ORG/ai-context.git ~/dev/ai-context
```

### 2. Configure Your Project

In your project root, create a `ai-context.json` file to define which documentation you need:

```json
{
  "sources": {
    "tailwind": "tailwind-v4",
    "ghost": "ghost-v6"
  },
  "hubPath": "~/dev/ai-context"
}
```

### 3. Sync

Add a sync script (e.g., `sync-context.sh`) to your project that reads this config and creates symlinks in `.context/`.
_The AI agent can generate this script for you._

When you run the sync script, it links the documentation from `~/dev/ai-context` directly into your project.

---

## 🛠 Maintenance (For Admins)

How to keep documentation up-to-date or add new libraries.

### Updating Existing Docs

1.  Open this repository locally (`cd ~/dev/ai-context`).
2.  Run the management script:
    ```bash
    ./manage_hub.sh
    ```
    _This will delete the old folders and re-download the latest source code from the official repositories._
3.  Commit and push the changes:
    ```bash
    git commit -am "chore: update docs"
    git push
    ```

### Adding a New Library

1.  Edit `manage_hub.sh`.
2.  Add a new entry using the `sync_repo` function:
    ```bash
    # sync_repo "Name" "RepoURL" "Branch" "DestDir" "SubPath (optional)"
    sync_repo "Stripe API" "https://github.com/stripe/stripe-docs" "master" "stripe-api" ""
    ```
3.  Run `./manage_hub.sh` to download the new data.
4.  Commit and Push.
