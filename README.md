# ✨ Zachary’s Bash‐Script Collection

Welcome!  
This repository is a grab-bag of shell scripts I’ve written over time to automate tasks, poke at servers, and generally make life on the command line a little smoother. I’m publishing them in the hope that they’ll spark ideas, save someone a few minutes, or at least provide a jumping-off point for your own tooling.

> **Heads-up before you copy-paste:**  
> Every script here was born in **my** environment (Linux, Bash 5.x, assorted CLI tools) and assumes paths, binaries, and defaults that may not match yours. Read the code first, tailor it to your system, and test in a non-production sandbox. I’d hate for a stray `rm -rf` or mis-pointed volume to ruin your day.

---

## Quick start

```bash
git clone https://github.com/<your-user>/<repo>.git
cd bash-scripts

# Examine a script
less docker/cleanup-dangling.sh

# Make it executable & run (AFTER editing!) 
chmod +x docker/cleanup-dangling.sh
./docker/cleanup-dangling.sh
````

1. **Read the header comments** – most scripts have inline usage examples and option flags.
2. **Dry-run where possible** (many tools support `--dry-run` or `-n`).
3. **Adapt paths / variables** – look for `CONFIG_DIR`, `LOG_ROOT`, etc.

---

## Contributing

Found a bug, typo, or improvement?

* Open an issue or PR – I’m happy to merge fixes that keep scripts broadly useful.
* Keep changes **idempotent & safe by default** (e.g., offload destructive actions behind `--force`).
* Stick to POSIX Bash where feasible; external deps should be common packages.

---

## License

MIT for now – do whatever you like, but **no warranty**. See `LICENSE` for the legalese.

---

## Final word

Scripts are like power tools: incredibly handy but best handled with respect.
If something here sparks joy (or frustration) drop me a note – I’d love to hear how you’ve adapted these ideas to your own workflow.

Happy hacking!
— **Zachary**

