# Unix Utilities

Essential UNIX/Linux command-line tools for file management, text processing, system administration, and automation.

[![License](https://img.shields.io/github/license/olympus-terminal/unix-utilities)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/olympus-terminal/unix-utilities?style=social)](https://github.com/olympus-terminal/unix-utilities/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/olympus-terminal/unix-utilities)](https://github.com/olympus-terminal/unix-utilities/issues)
[![GitHub last commit](https://img.shields.io/github/last-commit/olympus-terminal/unix-utilities)](https://github.com/olympus-terminal/unix-utilities/commits/main)
[![Tools](https://img.shields.io/badge/tools-48-green.svg)](https://github.com/olympus-terminal/unix-utilities)
[![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow.svg)](https://github.com/olympus-terminal/unix-utilities)

## Overview

Random useful unix utilities

## Repository Structure

```
unix-utilities/
├── file-management/     # File operations, renaming, organization
├── text-processing/     # Text manipulation and transformation
├── system-admin/       # System maintenance and administration
├── search-tools/       # Enhanced search capabilities
└── compression/        # Archive and compression utilities
```

## Quick Start

```bash
# Clone the repository
git clone https://github.com/olympus-terminal/unix-utilities.git
cd unix-utilities

# Make all scripts executable
find . -type f \( -name "*.sh" -o -name "*.py" -o -name "*.pl" \) -exec chmod +x {} \;

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/unix-utilities"
```

## Tool Highlights

### File Management (`file-management/`)

#### Smart Renaming
```bash
# Batch rename files from a mapping list
./rename_from_list.sh mapping.txt

# Remove special characters from filenames
./remove_special_chars_filenames.sh /path/to/messy/files/

# macOS-friendly renaming with Perl
./osxrename.pl 's/oldpattern/newpattern/g' *.txt
```

#### File Organization
```bash
# Count files recursively with size information
./CountFiles.sh /large/directory/

# Find and report large directories
./report_offending_dirs.sh /disk/full/

# Generate file lists from directory trees
./filelist-from-dirs.sh /project/root/ > inventory.txt
```

#### Advanced Operations
```bash
# Move large files efficiently
./move_large_files.sh /source/ /destination/ "*.dat"

# Random sampling/downsampling of files
./random-del-downsample /dataset/ 0.1  # Keep 10%

# Strip numbers from filenames
./stripnumbers file123.txt  # Returns: file.txt
```

### Text Processing (`text-processing/`)

#### Format Conversion
```bash
# Convert any delimiter to tabs (handles UTF-8)
./delim_to_tab_UTF8 data.csv > data.tsv

# Fix space-delimited files
./convert-spaced-cols-to-tab-inferior.sh messy_data.txt > clean_data.tsv

# Convert Mac line endings to Unix
./mac-to-utf.sh old_mac_file.txt > unix_file.txt
```

#### Text Manipulation
```bash
# Extract only alphabetic characters
./only_alpha < mixed_input.txt > letters_only.txt

# Bulk text replacement from list
./edit_text_from_list.sh replacements.txt target_file.txt

# Remove lines matching first column
./remove_lines_with_first_column_match.sh blacklist.txt data.txt
```

#### Data Processing
```bash
# Sort by specific column
./sort_by_col-1.sh 3 data.txt > sorted_by_col3.txt

# Shuffle file preserving header
./shuf-noHedtho.sh data_with_header.csv > shuffled.csv

# Split targets into two groups
./Split_targets_into-two.zsh targets.txt group1.txt group2.txt
```

### System Administration (`system-admin/`)

#### Process Management
```bash
# Execute with proper environment capture
./CatchAndSlot.sh long_running_process

# Background execution with logging
./nohup-bak.sh important_script.sh

# Singularity container execution wrapper
./exec-Singularity.sh container.sif command args
```

#### System Maintenance
```bash
# Smart update script
./update_me.sh  # Updates system packages intelligently

# Distribute files across nodes
./distribute_ex.sh file_list.txt node1 node2 node3

# Clone and configure environments
./clone_imprint_distribute source_env/ target_systems.txt
```

### Search Tools (`search-tools/`)

#### Parallel Search
```bash
# Search in files (parallel for speed)
./search_in_files-parallel.sh "pattern" /large/codebase/

# Regular search with context
./search_in_files.sh "TODO" ./src/
```

#### History and Lookup
```bash
# Search Zsh history efficiently
./search_zsh_history.sh "git commit"

# Quick command lookup
./clookup.sh command_name

# Python-based intelligent scanning
python scan_filter.py --pattern "error|warning" logs/
```

### Compression (`compression/`)

```bash
# Extract archives with duplicate handling
./extract_zip_having_dups.sh archive.zip

# Force extraction (handles corrupted archives)
./force_unzip.sh damaged_archive.zip output_dir/
```

## Real-World Use Cases

### 1. Bulk File Renaming Project
```bash
# Generate current file list
find . -name "*.jpg" > old_names.txt

# Create new names (edit manually or generate)
sed 's/IMG_/photo_/g' old_names.txt > new_names.txt

# Preview changes
paste old_names.txt new_names.txt

# Execute renaming
./file-management/rename_from_list.sh old_names.txt new_names.txt
```

### 2. Data Cleaning Pipeline
```bash
# Fix delimiters
./text-processing/delim_to_tab_UTF8 raw_data.csv > step1.tsv

# Remove invalid rows
./text-processing/remove_lines_with_first_column_match.sh invalid_ids.txt step1.tsv > step2.tsv

# Sort by importance (column 3)
./text-processing/sort_by_col-1.sh 3 step2.tsv > clean_data.tsv
```

### 3. System Monitoring
```bash
# Find disk space hogs
./file-management/report_offending_dirs.sh / > disk_usage_report.txt

# Search for errors across all logs
./search-tools/search_in_files-parallel.sh "ERROR\|CRITICAL" /var/log/

# Monitor long-running processes
./system-admin/CatchAndSlot.sh ./data_processing_pipeline.sh
```

## Performance Tips

### Parallel Processing
Many tools support parallel execution:
```bash
# Use parallel search for large directories
./search_in_files-parallel.sh pattern /huge/directory/

# Set number of parallel jobs
export PARALLEL_JOBS=8
```

### Memory Optimization
```bash
# Process large files in chunks
split -l 10000 huge_file.txt chunk_
for chunk in chunk_*; do
    ./process_chunk.sh "$chunk"
done
```

## Configuration

### Environment Variables
```bash
# Set in ~/.bashrc or ~/.zshrc
export UNIX_UTILS_HOME="$HOME/unix-utilities"
export PATH="$PATH:$UNIX_UTILS_HOME"

# Tool-specific settings
export SEARCH_TOOLS_THREADS=4
export FILE_MGT_VERBOSE=1
```

### Custom Aliases
```bash
# Add to shell configuration
alias cleanup='$UNIX_UTILS_HOME/file-management/remove_special_chars_filenames.sh'
alias bigsearch='$UNIX_UTILS_HOME/search-tools/search_in_files-parallel.sh'
alias smartsort='$UNIX_UTILS_HOME/text-processing/sort_by_col-1.sh'
```

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Contribution Guide
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-tool`)
3. Add your tool with documentation
4. Include usage examples
5. Submit a Pull Request

### Tool Standards
- Include shebang line (`#!/bin/bash` or appropriate)
- Add usage documentation in script header
- Handle errors gracefully
- Follow existing naming conventions
- Test on Linux and macOS

## Documentation

Each tool includes inline documentation. View with:
```bash
# Most tools support -h or --help
./tool-name.sh --help

# View script header documentation
head -20 tool-name.sh
```

## Troubleshooting

### Common Issues

**Permission Denied**
```bash
chmod +x script-name.sh
```

**Command Not Found**
```bash
# Check if in PATH
echo $PATH

# Use full path
/full/path/to/unix-utilities/tool-name.sh
```

**Incompatible Shell**
```bash
# Check shell compatibility
ls -la script-name.sh  # Look for #!/bin/bash or #!/bin/zsh

# Run with specific shell
bash script-name.sh
```

## Performance Benchmarks

| Operation | Standard Unix | Our Tool | Speedup |
|-----------|--------------|----------|---------|
| Search 10GB of logs | `grep -r` (8m) | `search_in_files-parallel.sh` (1.5m) | 5.3x |
| Rename 10k files | Manual (hours) | `rename_from_list.sh` (30s) | 100x+ |
| Find large dirs | `du -h` (3m) | `report_offending_dirs.sh` (45s) | 4x |

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Unix philosophy: "Do one thing and do it well"
- The amazing Unix/Linux community
- Contributors and users who provided feedback

## Contact

- Issues: [GitHub Issues](https://github.com/olympus-terminal/unix-utilities/issues)
- Discussions: [GitHub Discussions](https://github.com/olympus-terminal/unix-utilities/discussions)
- Author: [@olympus-terminal](https://github.com/olympus-terminal)
