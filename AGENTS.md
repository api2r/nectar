# AGENTS.md

## Repository overview

**nectar** — A Framework for Web API Packages

An opinionated framework for use within api-wrapping R
    packages.

https://nectar.api2r.org, https://github.com/api2r/nectar

### Overall structure

The project follows standard R package conventions with these key directories:

nectar/
├── R/                          # R source code
│   ├── nectar-package.R # Auto-generated package docs
│   └── *.R                     # Function definitions, 1 file ~= 1 exported function
├── .github/
│   ├── ISSUE_TEMPLATE/         # GitHub issue templates
│   ├── skills/                 # Agent skill definitions
│   └── workflows/              # CI/CD configurations
├── tests/testthat/             # Test suite
├── man/                        # Generated documentation
├── AGENTS.md                   # Main agent setup file
├── DESCRIPTION                 # Package metadata
├── NAMESPACE                   # Auto-generated export information
├── NEWS.md                     # Changelog
└── Various config files        # .gitignore, codecov.yml, etc.

---

## Standard workflow

For any feature, fix, or refactor:

1. **Update packages**: `pak::pak()`
2. **Run tests** — confirm passing before changes: `devtools::test(reporter = "check")`. If any fail, stop and ask.
3. **Plan** — identify affected R files; check if new exports are needed.
4. **Test first** — write failing test, then implement: `devtools::test(filter = "name", reporter = "check")`.
5. **Implement** — minimal code to pass tests.
6. **Refactor** — clean up, keep tests green.
7. **Document** — document any new or changed exports.
8. **Verify**: Run `devtools::test(reporter = "check")`, then `devtools::check(error_on = "warning")`. Resolve warnings, errors, and NOTEs.
9. **News** — add bullet at top of `NEWS.md` (under dev heading):
   - User-facing changes only. 1 line, end with `.`
   - Present tense, positive framing, function names (backticks + `()`) near start: `` * `fn()` now accepts ... `` not `* Fixed ...`
   - Issue/contributor before final period: `` * `fn()` now accepts ... (@user, #N). `` where `#N` is the GitHub issue number being implemented (e.g. `#42`).
   - Get username: `gh api user --jq .login`; get issue number from the user's prompt, the branch name (`git branch --show-current`), or `gh issue list`.
   - **Never guess or invent an issue number.** Before writing it, verify: (1) you received it from the user or the branch name, OR (2) you looked it up with `gh`. If you cannot trace the number to a concrete source, use `#noissue`.

---

## General

- R console: use `--quiet --vanilla`.
- Always run `air format .` after generating R code.
- Comments explain *why*, not *what*.
