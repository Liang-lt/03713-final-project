#!/bin/bash



#SBATCH -p RM-shared

#SBATCH -t 24:00:00

#SBATCH --ntasks-per-node=4



source ~/.bashrc

conda activate hal



export PATH=/ocean/projects/bio230007p/myang17/repos/hal/bin:$PATH


bash /ocean/projects/bio230007p/myang17/repos/halLiftover-postprocessing/halper_map_peak_orthologs.sh \-b /ocean/projects/bio230007p/myang17/final_project/mapping/idr.optimal_peak.narrowPeak \-o /ocean/projects/bio230007p/myang17/final_project/mapping/halper_result_mouse_human_liver \-s Mouse \-t Human \-c /ocean/projects/bio230007p/ikaplow/Alignments/10plusway-master.hal
