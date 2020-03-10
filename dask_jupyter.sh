#!/bin/bash


#SBATCH --nodes=2
#SBATCH --ntasks-per-node=16
#SBATCH --time=01:00:00
#SBATCH --begin=now
#SBATCH --mail-user=xxx.yyy@isae.fr
#SBATCH --mail-type=FAIL,END
#SBATCH --job-name=jupyter-notebook
#SBATCH -o    jupyter-log-%j.txt
#SBATCH -e    jupyter-log-%j.txt

module load python/3.7
source activate dask

## get tunneling info
#XDG_RUNTIME_DIR=""
ipnport=$(shuf -i8000-9999 -n1)
ipnip=$(hostname -i)

cd $SLURM_SUBMIT_DIR
## print tunneling instructions to jupyter-log-{jobid}.txt
echo  "
    Copy/Paste this in your local terminal to ssh tunnel with remote
    -----------------------------------------------------------------
    ssh -N -L $ipnport:$ipnip:$ipnport $USER@rainman
    -----------------------------------------------------------------

    Then open a browser on your local machine to the following address
    ------------------------------------------------------------------
    localhost:$ipnport  (prefix w/ https:// if using password)
    ------------------------------------------------------------------
    "
## start an ipcluster instance and launch jupyter server

export XDG_RUNTIME_DIR=""

jupyter-notebook --no-browser --port=$ipnport --ip=$ipnip
