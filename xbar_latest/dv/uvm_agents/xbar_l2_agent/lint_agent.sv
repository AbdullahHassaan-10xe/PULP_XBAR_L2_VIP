class lint_agent extends uvm_agent; //this is also called the master agent


    `uvm_component_utils(lint_agent);

    //agent components
    
    master_sequencer seqr;
    master_monitor mon1;
    master_driver drv;
    
    function new(string name = "lint_agent", uvm_component parent = null);
            super.new(name,parent);   
    endfunction
    
    
    //build phase
    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        seqr = master_sequencer::type_id::create("seqr",this);
        drv = master_driver::type_id:: create("drv",this);
        mon1 = master_monitor:: type_id :: create("mon1",this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        
        // connecting the ports 
        //connecting driver to the seqr
        drv.seq_item_port.connect(seqr.seq_item_export);
        //connecting monitor to the seqr
        mon1.port_item1.connect(seqr.fifo_export.analysis_export);

        
        
    endfunction

endclass: lint_agent
