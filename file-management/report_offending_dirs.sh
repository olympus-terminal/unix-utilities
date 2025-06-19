#report-offending-dirs.sh 
#!/bin/zsh

# Use du -h to get human-readable sizes and sort -hr to sort in descending order
du -h ./* | sort -hr | head -n 11 | awk '{print $2 " " $1}'
