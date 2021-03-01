#	This makefile assumes the file structure:
#
#	+---PARENT-FOLDER
#	|	+---rtl/
#	|	|	+---dependency_modules.v
#	|	|	+---verilog_modules.v
#	|	|	+---...
#	|	+---sim/
#	|	|	+---verilog_testbenches.v
#	|	|	+---...
#	|	+---Makefile (this file!!!)
#

BASE 	:= $(PWD)
SIMDIR 	:= $(BASE)/sim
RTLDIR 	:= $(BASE)/rtl

DOFILE := $(SIMDIR)/temp/setup.do

# Include any commonly referenced files (e.g. a prebuilt_gates.v file)
DEPS 		= \
	#$(RTLDIR)/

# Include all rtl or module files in this variable
RTL_FILES 	= \
	$(RTLDIR)/powerController.v

# Include all testbench files in this variable
TB_FILES 	= \
	$(SIMDIR)/powerController_tb.v

# This is the name of the testbench ModelSim will run (should be found in one of the included TB_FILES)
TB_NAME := powerController_tb


# Targets for make

compileall:	clean
	mkdir $(SIMDIR)/temp; vlib $(SIMDIR)/temp/workingDir; vmap work $(SIMDIR)/temp/workingDir; touch $(DOFILE);
	vlog $(DEPS) $(RTL_FILES) $(TB_FILES);
	
clean:
	if [ -d "$(SIMDIR)/temp" ]; then \
        rm -r $(SIMDIR)/temp; \
	fi

sim:		compileall
	echo "run -all" >> $(DOFILE); vsim -do $(DOFILE) -c $(TB_NAME);

sim_g: 		compileall
	echo "log -r /*" >> $(DOFILE); echo "onfinish stop" >> $(DOFILE); echo "do wave.do" >> $(DOFILE); vsim $(TB_NAME) -do $(DOFILE) -gui;

# ```write format wave wave.do``` in ModelSim to save current wave configuration