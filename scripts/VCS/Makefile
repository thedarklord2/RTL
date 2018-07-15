################################################################################
################ Makefile Definitions
################################################################################
# Machine Name
M_HOST      := $(shell hostname)
DESIGN_HOME ?= $(shell pwd)
$(warning WARNING DESIGN_HOME set to $(DESIGN_HOME)) 

# Must have a pointer to design compiler
ifndef SYNOPSYS
  $(error ERROR SYNOPSYS environment variable is undefined )
endif

vpath %.v $(DESIGN_HOME)/RTL $(DESIGN_HOME)/TB

############### For Verilo (VCS) ################
#################################################

MODULE_NAME        ?=  ch_4

TEST_MODULE        ?=  ch_4

VLOG_LIST          ?=  filelist

VCS_CC             ?=  gcc

COMPILER           :=  vcs

EXECUTABLE         :=  ./simv

VERILOG_ENV        :=		 

VERILOG_DESIGN     :=	

VERILOG_FILES      :=				

VERILOG_LIBS       :=	

VERILOG_DC_ROOT    :=  $(SYNOPSYS)

VERILOG_DW_SIM_DIR :=  $(VERILOG_DC_ROOT)/dw/sim_ver/

VERILOG_GT_SIM_DIR :=  $(VERILOG_DC_ROOT)/packages/gtech/src_ver/


# "-sverilog"- --------------------->  enables system verilog
# "+lint=PCWM" --------------------->  enables linting error messages
# "+libext+.v" --------------------->  specifies that library files (imported by the "-y" directive) ends with ".v"
# "-notice"------------------------->  used to get details when ports are coerced to inout
# "-full64"------------------------->  for 64 bit compilation and simulation
# "+v2k"---------------------------->  for verilog 2001 constructs such as generate
# "-timescale=1ns/1ps"-------------->  sets the time unit and time precision for the entire design
# "+noportcoerce"------------------->  compile-time option to shut off the port coercion for the entire design
# "-top topModuleName"-------------->  specifies the top module
# "-f verilogFiles.list" ----------->  specifies a file that contains list of verilog files to compile


SIM_CLK_PERIOD        ?= 2

VCS_SAIF_FILE         ?= $(MODULE_NAME)_act.saif

VERILOG_LINT_FLAGS    :=    +lint=PCWM		\
			                +lint=UV		\
			                +lint=IRIMW		\
			                +lint=FIAAS		\
			                +lint=CAWM-L	\
			                +lint=ERASM-L	\
			                +lint=TFIPC-L   \
			                +lint=all		\
			                -ova_lint		\
			                -ova_lint_magellan	\
			                -notice			\
			                +warn=all



VERILOG_COMPILE_FLAGS := 	$(VERILOG_LINT_FLAGS)       \
				            -sverilog 					\
				            +cli 						\
				            +memcbk 					\
				            +libext+.v					\
				            +libext+.inc				\
				            -full64						\
				            +v2k						\
							+vcs+vcdpluson              \
				            -debug_pp					\
				            -timescale=1ns/1ps			\
				            +noportcoerce         		\
				            -diag timescale             \
				            -lca						\
				            -ld $(VCS_CC) 				\
				            -top $(TEST_MODULE)			\
				            -parallel+saif=1			\
				            +vcs+saif_libcell			\
				            -f $(VLOG_LIST) 	\
				            $(VERILOG_FILES) $(VERILOG_LIBS)

# "+vpdbufsize+100" limit the internal buffer to 100MB (forces flushing to disk)
# "+vpdports" Record information about ports (signal/in/out)
# "+vpdfileswitchsize+1000" limits the wave file to 1G (then switch to next file)
VERILOG_SIMULATION_FLAGS := 	$(VERILOG_SIMULATION_FLAGS) 	\
				                -l $(EXECUTABLE).log			\
								+ntb_random_seed=80 \
				                +vpdbufsize+100					\
				                +vcs+lic+wait					\
				                +vpdfileswitchsize+100			\
				                +VCS_SAIF_FILE=$(VCS_SAIF_FILE) 

##### END OF FLAGS FOR SYNOPSYS COMPILATION ####

################################################################################
################ Makefile Rules
################################################################################
# VCS rules:
#####################
# compile rules:
# use "make COMP=+define+<compile_time_flag[=value]>" to add compile time flags
.PHONY: comp 
comp         :  $(EXECUTABLE)

$(EXECUTABLE):	$(VERILOG_FILES) $(VLOG_LIST)
	            @echo ""
	            @echo Making $@ because of $?
	            @echo ==================================================
	            @(if [ "$(SIM_ENGINE)" = "mentor" ]; then 	\
	                vlib work;					\
	              fi )
	            $(COMPILER)  $(VERILOG_COMPILE_FLAGS) $(COMP) | tee comp.log


# Simulation rules:
#####################
# use "make run RUN=+<runtime_flag[=value]>" to add runtime flags
.PHONY: run run_wave
run_wave:    vcdplus.vpd

vcdplus.vpd: $(EXECUTABLE)
	         @echo ""
	         @echo Now Running $(EXECUTABLE) with wave
	         @echo ==================================================
	         -$(EXECUTABLE) +wave $(VERILOG_SIMULATION_FLAGS) $(RUN)

viz:         vcdplus.vpd
	         dve -full64 -vpd vcdplus.vpd &

simLog.txt:  $(EXECUTABLE)
	         @echo ""
	         @echo Now Running $(EXECUTABLE)
	         @echo ==================================================
	         -$(EXECUTABLE) $(VERILOG_SIMULATION_FLAGS) $(RUN) | tee simLog.txt

run:         simLog.txt

# Cleanup rules:
#####################
.PHONY: clean cleanall 
clean: 
	  @echo ""
	  @echo Cleanning old files, objects, logs and garbage
	  @echo ==================================================
	  \rm -rf $(EXECUTABLE) $(EXECUTABLE).*
	  \rm -rf csrc simLog.txt 
	  \rm -rf *.log *.vcd ucli.key
	  \rm -rf vc_hdrs.h report

cleanall: clean
	                \rm -rf DVE*
	                \rm -rf vcdplus.vpd
