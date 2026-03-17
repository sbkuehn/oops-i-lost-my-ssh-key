# Azure VM SSH Key Recovery Repo

Author: Shannon Eldridge-Kuehn  
Date: 2026-03-17

## Why this repo exists

If you've ever lost an SSH key to an Azure VM after switching machines, you already know the feeling.

This repo gives you two ways to fix it depending on how you like to work.

## Two approaches

### quick-fix/

This is the "just get me back in" version.

- minimal scripts
- edit a few lines and run
- designed to pair with the blog post

Use this when you want speed over structure.

---

### production-ready/

This is the "I want to reuse this safely" version.

- parameterized scripts
- basic validation
- repeatable across environments

Use this when you want something a bit more durable.

---

## Recommendation

Start with **quick-fix/**.

Move to **production-ready/** when you want something reusable.
