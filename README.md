# DATAEKO Week 1 — Assignment 1

Write a shell script that reads `app.log` and prints a summary. Then send it to
us as a pull request.

About **90 minutes**. Everything you need was taught in Session 1 and Session 2.

---

## What you are building

A script called `logsum.sh`. It takes the log file as its argument and prints a
summary of what is in it.

```bash
./logsum.sh app.log
```

`app.log` is in this repo. It is 2,000 lines, one event per line, five fields:

```
2026-08-01 08:00:59 ERROR checkout-api upstream timeout after 319ms
└─ date ──┘ └ time ┘ └lvl┘ └─ service ─┘ └──── message ────────────┘
```

There is nothing hidden in it. No JSON, no multi-line entries, no tricks. One
line is one event, so `wc -l` really is the number of events.

---

## What it must print

Exactly this shape, with your numbers:

```
LOG SUMMARY
===========
File:  app.log
Lines: 2000

Level counts
  INFO    1437
  WARN     322
  ERROR    241

Errors by service
  search          116
  checkout-api     51
  inventory        29
  auth-service     29
  mailer           16

Worst service: search (116 errors)
```

Errors by service must be sorted, most errors first.

## What it must do when it goes wrong

| You run | It prints | It exits |
|---|---|---|
| `./logsum.sh app.log` | the summary | `0` |
| `./logsum.sh` | a usage line, on stderr | `1` |
| `./logsum.sh nope.log` | an error line, on stderr | `2` |

Check the exit code with `echo $?`.

---

## How to submit

You do **not** need to be added to this repo. Fork it, work in your fork, and
open a pull request back here. That is how every open-source contribution works.

**1. Fork this repo** — the Fork button, top right of this page.

**2. Clone your fork and make a branch.**

```bash
git clone https://github.com/<your-username>/dataeko-week1-assignment.git
cd dataeko-week1-assignment
git switch -c submission/<your-username>
```

**3. Put your work in your own folder** so nobody's submission collides with
anybody else's.

```
submissions/<your-username>/logsum.sh
submissions/<your-username>/output.txt
```

`output.txt` is what your script printed — redirect it:

```bash
./submissions/<your-username>/logsum.sh app.log > submissions/<your-username>/output.txt
```

**4. Commit as you go**, not all at the end. Three or four commits with real
messages, not one commit called `final`.

```bash
git add submissions/<your-username>
git commit -m "Add level counts to logsum.sh"
git push -u origin submission/<your-username>
```

**5. Open the pull request.** GitHub will offer a "Compare & pull request"
button after you push. Base repo is this one, base branch `main`.

Title it `Week 1 — <your name>`. In the description, answer two questions in one
sentence each:

- Which service would you look at first, and why?
- What was the fiddliest part of the script?

Then paste the PR link where you were told to send it.

---

## Rules

- **Bash only.** No Python, no jq, no installing anything. `grep`, `cut`, `awk`,
  `sort`, `uniq`, `wc` and `printf` are all you need.
- **Do not commit `app.log`** into your submissions folder. It is already here.
- Use AI if you want, but you will be asked to explain any line of it.

## How it is marked

| | |
|---|---|
| The script runs and prints the right numbers | 40 |
| Output matches the format above | 20 |
| Exit codes 0 / 1 / 2 behave as specified | 15 |
| Branch, several real commits, PR opened correctly | 20 |
| The two questions answered in the PR description | 5 |

Late is fine. Silently stuck is not — ask.
