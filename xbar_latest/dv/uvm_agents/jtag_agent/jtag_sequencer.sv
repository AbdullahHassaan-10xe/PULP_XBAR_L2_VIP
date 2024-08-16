//  Class: jtag_sequencer
//
class jtag_sequencer extends uvm_sequencer#(jtag_sequence_item);
    `uvm_component_utils(jtag_sequencer);
    
    //constructor
    function new(string name = "jtag_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

endclass: jtag_sequencer
