#!/bin/bash

ls -d */ | cut -d'/' -f1 >> filelist.txt
