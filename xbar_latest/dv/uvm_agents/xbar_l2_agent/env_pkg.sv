//contains all the elements of env
package env_pkg;

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/seq_item_master.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/seq_item_slave.sv"  
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/master_sequencer.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/slave_sequencer.sv"
  
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/p_sequencer.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/master_driver.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/slave_driver.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/slave_monitor.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/master_monitor.sv"
    
    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/lint_agent.sv"

    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/lint_agent_1.sv"

    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/scoreboard_xbar_l2.sv"

    `include "/home/abdullah_hassaan/Documents/Coverage_check_xbar_l2/Coverage_check_xbar_l2/xbar_latest1_coverage_extnd/xbar_latest/dv/uvm_agents/xbar_l2_agent/lint_env.sv"

  


endpackage : env_pkg
