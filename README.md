# AI Context Hub

A centralized, versioned repository for official documentation, designed to provide "Source of Truth" context for AI coding assistants like Antigravity.

## 🚀 Usage (For Developers)

To use this context in your project:

### 1. Setup the Hub (Once per machine)

Clone this repository to a standard location on your machine:

```bash
mkdir -p ~/dev
git clone https://github.com/andreasdiehl/ai-context.git ~/dev/ai-context
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

You can sync the context to your project either automatically or manually.

#### Option A: Automatic Script (Recommended)

Add a user script (e.g., `sync-context.sh`) to your project that reads `ai-context.json` and creates the links.
_The AI agent can generate this script for you._

#### Option B: Manual Linking

You can manually create symbolic links from the Hub to your project's `.context` folder.

1.  Create the context folder:
    ```bash
    mkdir -p .context
    ```
2.  Link the libraries you need (check `~/dev/ai-context` for available options):

    ```bash
    # Example: Link Tailwind v4
    ln -s ~/dev/ai-context/tailwind-v4 .context/tailwind

    # Example: Link Ghost v6
    ln -s ~/dev/ai-context/ghost-v6 .context/ghost
    ```

---

## 🛠 Maintenance (For Admins)

How to keep documentation up-to-date or add new libraries.

### Updating Existing Docs

1.  Open this repository locally
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
