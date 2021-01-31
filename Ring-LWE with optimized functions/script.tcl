############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project encdec_final
set_top encdec
add_files  HLS_source/lwe.c
open_solution "solution1"
set_part {xc7z020clg484-1} -tool vivado
create_clock -period 17 -name default
#source "./encdec_final/solution1/directives.tcl"
#csim_design
csynth_design
#cosim_design
export_design -rtl verilog -format ip_catalog
