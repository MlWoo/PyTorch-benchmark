#!/bin/bash
export MKL_DOMAIN_NUM_THREADS="MKL_BLAS=8" 
export MKL_DYNAMIC=false 
export OMP_NUM_THREADS=8
/opt/intel/vtune_amplifier_xe/bin64/amplxe-cl  -run-pass-thru=--no-altstack -c hotspots -knob analyze-openmp=true --resume-after 5 -- python berkely.py
