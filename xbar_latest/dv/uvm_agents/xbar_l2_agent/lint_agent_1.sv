class lint_agent_1 extends uvm_agent; //this is also called the slave agent


    `uvm_component_utils(lint_agent_1);

    //agent components
    
    slave_sequencer r_seqr;
    slave_monitor mon;
    slave_driver drv1;
    
    function new(string name = "lint_agent_1", uvm_component parent = null);
            super.new(name,parent);   
    endfunction
    
    
    //build phase
    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        
        r_seqr = slave_sequencer::type_id::create("r_seqr",this);
        drv1 = slave_driver::type_id:: create("drv1",this);
        mon = slave_monitor:: type_id :: create("mon",this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        
        // connecting the ports 
    
        //connecting driver to the r_seqr
        drv1.seq_item_port.connect(r_seqr.seq_item_export);
        //connecting monitor to the r_seqr
        mon.port_item.connect(r_seqr.fifo_export1.analysis_export);  

        //connecting slave_monitor to master_driver
        //drv.port_item_adr.connect(mon.port_item_adr);
        
    endfunction

endclass: lint_agent_1
