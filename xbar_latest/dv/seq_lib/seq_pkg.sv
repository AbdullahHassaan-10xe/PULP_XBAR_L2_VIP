//contains all the sequence files including virtual sequence (named as p_seq)
package seq_pkg;

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    `include "seq_master.sv"
    
    `include "seq_slave.sv"  
   
    `include "p_seq.sv"
  
endpackage : seq_pkg
