#!/bin/bash

<mac OSx> caffeinate -s rsync -Prvt source/ destination/ 

<unix> nohup rsync -Prvt source/ destination/ > rsync.log 2>&1 &
       tail -f rsync.log
