class  slave_sequencer extends uvm_sequencer #(seq_item_slave );

    `uvm_component_utils(slave_sequencer)
    
    //analysis fifo used for self checking sequences (if used)
    
    uvm_tlm_analysis_fifo #(seq_item_slave) fifo_export1; 


    function new(string name ,uvm_component parent);
        super.new(name,parent);
        //analysis fifo constructor
        fifo_export1 = new("fifo_export1", this);
    endfunction 
    
endclass  
