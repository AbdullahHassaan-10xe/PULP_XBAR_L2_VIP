//  Class: jtag_agent
//
class jtag_agent extends uvm_agent;
    `uvm_component_utils(jtag_agent);

    // Components
    jtag_driver driver;
    jtag_monitor monitor;
    jtag_sequencer sequencer;

    //  Constructor: new
    function new(string name = "jtag_agent", uvm_component parent= null);
        super.new(name, parent);
    endfunction

    // build agent components
    virtual function void build_phase(uvm_phase phase);
        driver = jtag_driver::type_id::create("driver",this);
        monitor = jtag_monitor::type_id::create("monitor",this);
        sequencer= jtag_sequencer::type_id::create("sequencer",this);
    endfunction: build_phase

    // connecting sequencer to driver

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase
    
endclass: jtag_agent




    