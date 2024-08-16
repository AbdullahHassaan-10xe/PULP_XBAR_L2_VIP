
/**
 * Encapsulates all the types needed for an UVM agent capable of driving and/or
 * monitoring JTAG Interface .
 */ 

package jtag_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    // Virtual Base Class for Driver Accessor
    virtual class driver_accessor  extends uvm_object;

        function new(input string name = "abstract");
            super.new(name);
        endfunction: new
        // Accessor class virtual tasks
        pure virtual function logic set_tms(logic tms);
        pure virtual task set_tdi(logic value);
        pure virtual task automatic wait_clks(input int num);
        pure virtual task automatic wait_clks_neg(input int num);

    endclass : driver_accessor  
    
    // Virtual Base Class for Monitor Accessor
    virtual class mointor_accessor  extends uvm_object;

        function new(input string name = "abstract");
            super.new(name);
        endfunction: new
        // Accessor class virtual tasks
        pure virtual function logic get_tdo();
        pure virtual task automatic wait_clks(input int num);
        pure virtual task automatic wait_clks_neg(input int num);   

    endclass : mointor_accessor     

    // Typedefs and Sequence_items 
    `include "jtag_tdefs.sv"
    `include "jtag_sequence_item.sv"

    // Agent Components
    `include "jtag_sequencer.sv"
    `include "jtag_driver.sv"
    `include "jtag_monitor.sv"
    `include "jtag_agent.sv"
    `include "scoreboard.sv"
    `include "jtag_env.sv"


    // Sequences
    `include "jtag_sequence.sv"

    // Tests
    `include "jtag_test.sv"

endpackage : jtag_pkg    