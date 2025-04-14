#!/bin/bash

nohup rsync -avh data_folder/ user@archive:/path/to/backup/ > rsync_$(date +%Y%m%d_%H%M%S).log 2>&1 &

