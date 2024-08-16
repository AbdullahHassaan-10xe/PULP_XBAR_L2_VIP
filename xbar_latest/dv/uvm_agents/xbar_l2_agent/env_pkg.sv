//contains all the elements of env
package env_pkg;

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    `include "seq_item_master.sv"
    
    `include "seq_item_slave.sv"  
    
    `include "master_sequencer.sv"
    
    `include "slave_sequencer.sv"
  
    `include "p_sequencer.sv"
    
    `include "master_driver.sv"
    
    `include "slave_driver.sv"
    
    `include "slave_monitor.sv"
    
    `include "master_monitor.sv"
    
    `include "lint_agent.sv"

    `include "lint_agent_1.sv"

    `include "scoreboard_xbar_l2.sv"

    `include "lint_env.sv"

  


endpackage : env_pkg
