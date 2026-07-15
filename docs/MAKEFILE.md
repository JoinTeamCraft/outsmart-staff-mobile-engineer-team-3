# Makefile Documentation

This project uses a `Makefile` to simplify common development tasks. It automates repetitive terminal commands and ensures consistency across different environments.

## How to use
Run the following commands in your terminal from the root directory of the project:

### Flutter Commands
* `make pub-get`: Fetches project dependencies.
* `make clean-build`: Runs `flutter clean` and fetches dependencies.

### Code Generation
* `make gen`: Executes a one-time build for code generation.
* `make watch`: Starts the `build_runner` watcher for continuous updates (recommended during development).
* `make gen-clean`: Clears the generated file cache.

### Maintenance
* `make full-clean`: Performs a complete reset of the project by cleaning both Flutter build artifacts and generated code caches.

---

## Technical Note: Syntax Requirements
The `Makefile` requires **Tab characters** for indentation before commands. 

### Troubleshooting "No rule to make target"
If you receive a `No rule to make target` error, it is almost certainly because the editor converted **Tabs to spaces**. 

**How to fix in VS Code:**
1. Open the `Makefile`.
2. Look at the bottom-right status bar. If it says "Spaces: 4", click it.
3. Select **"Convert Indentation to Tabs"**.
4. Save the file and try the command again.

---

## Quick Reference for Maintenance
| Command | Action |
| :--- | :--- |
| `make pub-get` | Update packages |
| `make clean-build` | clean and update all packages |
| `make gen` | generate all required code |
| `make test` | run all local tests |
| `make watch` | Start code generation (Development) |
| `make gen-clean` | Clean all code generation |
| `make full-clean` | Deep clean of project cache |
