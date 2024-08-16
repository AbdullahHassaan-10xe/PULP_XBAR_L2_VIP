class JTAG_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(JTAG_scoreboard)
    
    //logic parameters
        logic [31:0] expected_data;
        logic [31:0] actual_data;
    //TLM Analysis fifos
    uvm_tlm_analysis_fifo#(logic [31:0]) mon_data_fifo;
    uvm_tlm_analysis_fifo#(logic [31:0]) drv_data_fifo;
    
    // new- constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_data_fifo = new("mon_data_fifo",this);
        drv_data_fifo = new("drv_data_fifo",this);
    endfunction : new

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        mon_data_fifo.get(expected_data);
        drv_data_fifo.get(actual_data);
        $display("expected_data = ",expected_data);
        $display("actual_data  = ",actual_data);
        if(expected_data == actual_data)
            `uvm_info(get_name() , "Comparison Passed " , UVM_NONE)
        else
            `uvm_info(get_name(), "Comparison Failed" , UVM_NONE )
        
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: run_phase
    
endclass : JTAG_scoreboard