# Agent Instructions

## CRITICAL: Data Integrity Policy

**NEVER create scripts or figures using synthetic, simulated, or randomly generated data as a substitute for real experimental results.**

This includes:
- DO NOT use `np.random`, `torch.rand`, or similar functions to generate fake scientific data for publication figures
- DO NOT create "improved" or "cleaned up" visualizations based on summary statistics instead of raw data
- DO NOT reconstruct attribution patterns, gradients, or any analysis results from partial information
- DO NOT generate placeholder data for CAV analysis, uncertainty quantification, or any interpretability methods
- DO NOT fabricate metadata: no invented PFAM descriptions, gene names, GO terms, or pathway annotations
- If annotation data is not in a local file or successfully retrieved from an API, state "annotation not available"

**Acceptable uses of random functions:**
- Standard ML training operations (batch sampling, weight initialization, dropout)
- Statistical bootstrapping or resampling of real data
- Test cases clearly marked as synthetic for unit testing only

**If real data is unavailable:** Stop and request the actual data rather than generating synthetic alternatives.

## Core Principles

- Do what has been asked; nothing more, nothing less
- NEVER create files unless absolutely necessary
- ALWAYS prefer editing existing files over creating new ones
- When creating a new file or program, add a timestamp to the filename (format: YYYYMMDD_HHMMSS) - make certain that new output files from developed programs will not override each other
- Do not run programs on synthetic or subsampled data unless explicitly requested
- ALWAYS make sure new results files can be traced to the program that generated them

## Explicit "Never" List

- NEVER force push (`git push --force`)
- NEVER delete files outside the current project directory
- NEVER skip tests or linting to make a task "pass"
- NEVER add production dependencies unless explicitly requested
- NEVER read, write, log, or commit secret/credential files (`.env`, API keys, tokens)
- NEVER modify databases, config files, or infrastructure outside the scope of the current task
- NEVER silently swallow errors or exceptions to make code appear to work

## Escalation Rules

- If tests fail after 3 attempts: **stop and report** the failure with full error output. Do not improvise workarounds.
- If a required file, dataset, or dependency is missing: **stop and ask** rather than substituting.
- If a task requires destructive operations (deleting data, dropping tables, resetting state): **stop and confirm** before proceeding.
- If instructions are ambiguous or contradictory: **stop and ask** for clarification rather than guessing.

## Temporary Files

- When using `/tmp`, always create a unique temp directory per agent/session:
  `mktemp -d "${TMPDIR:-/tmp}/agent_${USER:-user}_XXXXXX"`
- Do not write to predictable shared paths like `/tmp/output.txt`, `/tmp/results.csv`, or `/tmp/cache`
- Only delete temp files or directories created by the current session
- Do not store durable results, provenance-relevant outputs, figures, or analysis artifacts in `/tmp`; write those under the project/output tree with timestamped filenames

## Memory-Efficient Coding

**ALWAYS prioritize memory-efficient implementations by default:**

- **Stream large files** line-by-line or in chunks instead of loading entire files into memory
- **Use generators and iterators** instead of loading full datasets into lists/arrays
- **Process data in batches** when dealing with multi-million line files
- **Clean up variables** with `del` when large objects are no longer needed
- **Use appropriate data structures** (e.g., numpy arrays vs lists, pandas chunking)
- **Estimate memory usage** before loading data (file size x parsing overhead)
- **Profile memory consumption** for scripts handling >1M lines or >1GB files

**Common patterns to AVOID:**
- `lines = file.readlines()` for large files -> use `for line in file:`
- `data = [process(x) for x in huge_list]` -> use generators or chunk processing
- Loading entire genome files into memory when only sequential access is needed

**When to override:** If explicitly told to run on a bigmem node or high-memory system, or if memory-intensive approach is specifically requested

## Script Development & Testing

**Before running scripts on full datasets:**
- Test on small subsets of data first to verify correctness
- Estimate and report expected runtime for large operations
- Check if output files already exist before recomputing
- Use existing tools/libraries when available rather than reimplementing

**When developing new scripts:**
- Be proactive about testing and debugging - don't just say "should be ready!" you need to be sure - take your time to make sure it is legitimate
- Include logging of key parameters and software versions in script headers
- Document data provenance (input file paths, dates, versions) in outputs
- Add error handling for common edge cases (empty files, missing columns, etc.)

## Verification and "Done When"

- Every non-trivial task must have a verifiable completion condition
- Do not report a task as complete without running the verification step
- Prefer file-scoped test commands over full test suite runs for faster feedback
- Without tests, the agent has no guardrails: write tests first when possible (TDD)

## Parallel Agent Work

- Use git worktrees for parallel agents working on the same repository
- Map file assignments before dispatching subagents: overlapping assignments waste tokens and produce conflicts
- Be aware of shared resources beyond git: databases, ports, lock files, and caches can cause race conditions even with worktrees isolated
- For small, single-file changes: do the work inline rather than delegating to a subagent

## Task Structure

When accepting non-trivial tasks, ensure these four elements are clear (ask if not):

1. **Goal** - the desired outcome
2. **Context** - relevant files, errors, documentation
3. **Constraints** - standards, architecture boundaries, safety requirements
4. **Done when** - verifiable completion condition with specific commands or checks

## Explaining Results

When asked to explain analysis results or figures:
1. Show the exact code/formula that generated the data FIRST
2. Print actual numerical values (not descriptions)
3. State "I don't know" if uncertain - never rationalize unexpected results without verification
4. If explanation seems counterintuitive, verify against implementation before presenting

## Visualizations

1. REFER TO FIGURE_PROTOCOL.MD for visualization rules i.e., creating figures, graphics, etc.
2. View any generated graphics to ensure adherence to FIGURE_PROTOCOL.md, especially regarding text overlapping with other figure elements
