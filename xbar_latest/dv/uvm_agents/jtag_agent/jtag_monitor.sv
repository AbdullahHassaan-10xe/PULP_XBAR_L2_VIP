//  Class: jtag_monitor
//
class jtag_monitor extends uvm_monitor;
    `uvm_component_utils(jtag_monitor);
        // TLM analysis port 
        uvm_analysis_port#(logic [31:0]) ap;

        mointor_accessor accessor;//  Acessor Class Variable 
        
        uvm_event ev; //Step-1. Declaring the event
    
        logic [31:0] data;
        //  Constructor: new
    function new(string name = "jtag_monitor", uvm_component parent);
        super.new(name, parent);
        ap = new("ap",this);
    endfunction: new    

    //build phase   
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // using the config_db get method to get the accessor class handle
        if(!uvm_config_db#(mointor_accessor)::get(null,"" ,"accessor_mon", accessor))
        begin
            `uvm_fatal("No_accessor",{"Accessor must be set for :",get_full_name(),".accessor"});
        end
    endfunction: build_phase


    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        //Step-2. Get the event handle from event pool
        ev = uvm_event_pool::get_global("ev_ab");
        
        `uvm_info(get_type_name(),$sformatf(" waiting for the event trigger"),UVM_LOW)    
        //Step-3.waiting for event trigger
        ev.wait_trigger;
        `uvm_info(get_type_name(),$sformatf(" event got triggerd"),UVM_LOW)
        // Observing the TDO signal
        accessor.wait_clks(1);
        for (int i = 0; i < 32 ; i++) begin
            accessor.wait_clks(1);
            data[i] = accessor.get_tdo();
        end
        // Analysis Port Write methood
        ap.write(data);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: run_phase
    
endclass: jtag_monitor