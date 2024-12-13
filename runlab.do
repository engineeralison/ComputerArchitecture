# NOTES:
#  - The most important thing is locating where all of the files
#    are and specifying the correct paths (absolute or relative)
#    in the commands below.
#  - You will also need to make sure that your current directory
#    (cd) in ModelSim is the directory containing this .do file.


# Create work library
vlib work


# Compile Verilog
#  - All Verilog files that are part of this design should have
#    their own "vlog" line below.
vlog "./alustim.sv"
vlog "./alu.sv"
vlog "./alu1bit.sv"
vlog "./adder.sv"
vlog "./test_zero.sv"
vlog "./mux.sv"
vlog "./mux1.sv"
vlog "./SE.sv"
vlog "./math.sv"
vlog "./adder64bit.sv"
vlog "./dflipflop.sv"
vlog "./instruction_datapath.sv"
vlog "./MOV.sv"
vlog "./regstim.sv"
vlog "./regfile.sv"
vlog "./mux_tb.sv"
vlog "./instructmem.sv"
vlog "./flagReg.sv"
vlog "./decoder_tb.sv"
vlog "./datamem.sv"
vlog "./CPU_datapath.sv"
vlog "./CPU_control.sv"
vlog "./CPU.sv"


# Call vsim to invoke simulator
#  - Make sure the last item on the line is the correct name of
#    the testbench module you want to execute.
#  - If you need the altera_mf_ver library, add "-Lf altera_mf_lib"
#    (no quotes) to the end of the vsim command
vsim -voptargs="+acc" -t 1ps -lib work CPU_tb


# Source the wave do file
#  - This should be the file that sets up the signal window for
#    the module you are testing.
do CPUwave.do


# Set the window types
view wave
view structure
view signals


# Run the simulation
run -all


# End
