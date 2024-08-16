class jtag_base_test extends uvm_test;
  `uvm_component_utils(jtag_base_test)
    
  base_sequence base_seq;
  jtag_env env_h;

  // Default Construtor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  // Building Environment And  base_sequence
  function void build_phase(uvm_phase phase);
    env_h = jtag_env::type_id::create("env_h",this);
    base_seq= base_sequence::type_id::create("base_seq",this);
  endfunction

  // Printing Topolgy
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    // Sequence Getting Started
    base_seq.start(env_h.jtag_agnt.sequencer);
    phase.drop_objection(this);   
  endtask
    
endclass