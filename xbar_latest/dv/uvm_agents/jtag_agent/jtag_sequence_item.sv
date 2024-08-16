//  Class: jtag_sequence_item
//
class jtag_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(jtag_sequence_item);

    //Actions to be performed by JTAG
    rand jtag_seq_item_action_enum action;  
    // Number of times the Data Need to be shifted 
    rand int length;
    // Data to be Shifted
    rand logic [31:0] shift_data;
    // JTAG I/Os
    logic TCK;
    logic TMS;
    logic TDI;
    logic TDO;

   /**
    * Default constructor.
    */
    function new(string name = "jtag_sequence_item");
        super.new(name);
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    // extern function string convert2string();
    //  Function: do_print
    // extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();
    
endclass: jtag_sequence_item



