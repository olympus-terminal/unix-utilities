###Singularity> cat exec.sh 
#!/bin/bash

singularity exec --overlay overlay-50G-10M.ext3:rw /scratch/work/public/singularity/cuda12.3.2-cudnn9.0.0-ubuntu-22.04.4.sif  /bin/bash
