#When in new terminal remember to do  csh and then "source ~/cshrc"


#########################################################################################
# Xcelium binary and arguments
#########################################################################################
XSIM = xrun
XSIM_OPTS = -sv
UVM = -uvm
COMP = -compile
flist = soc_flist.f
tb_top = tb_top
UVM_TESTNAME = base_test


# Coverage Options
COVERAGE_COMPILE = -coverage all
COVERAGE_SIM = -coverage all

main: compile sim

all: clean compile sim imc

compile: 
	$(XSIM) $(XSIM_OPTS) $(UVM) $(COMP) -f $(flist)

sim:
	@echo "Simulating the lint target..."
	$(XSIM) $(XSIM_OPTS) $(UVM) -f $(flist) -top $(tb_top) +$(UVM_TESTNAME) +UVM_VERBOSITY=UVM_HIGH -covfile ccf_files/cov_file.ccf -covtest $(UVM_TESTNAME)

imc:
	imc -gui -load cov_work/scope/base_test

clean:
	rm -rf *.vdb csrc *.log work *.key *.txt *.history *.do cov_work

.PHONY: main compile sim clean


#the uvm_test to be run is to be displayed directly in the tb_top run_test option!!!
