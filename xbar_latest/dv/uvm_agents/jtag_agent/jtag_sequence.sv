//  Class: jtag_sequence
//
class base_sequence extends uvm_sequence#(jtag_sequence_item);
  `uvm_object_utils(base_sequence);
   jtag_sequence_item seq_item;
  /* Default constructor.
  */
  function new(string name = "jtag_sequence");
      super.new(name);
  endfunction: new

  task body();
    
    // Reset Sequence
    req = new();
    start_item(req);
    assert(req.randomize() with {req.action == JTAG_SEQ_ITEM_ACTION_SYNC_RESET; 
                                      req.length == 5;
                                      req.shift_data == 32'h1f;                      
                                    });
    `uvm_info("Sequence","jtag_Sequence_item",UVM_NONE)
    finish_item(req);
    
    // Shift-IR Sequence
    req = new();                    
    start_item(req);
    assert(req.randomize() with {req.action == JTAG_SEQ_ITEM_ACTION_SHIFT_IR; 
                                      req.length == 5;
                                      req.shift_data == 32'h1f;                      
                                    });
    `uvm_info("Sequence","jtag_Sequence_item",UVM_NONE)
    finish_item(req);
    
    // Shift-DR Sequence
    req = new();
    start_item(req);
    assert(req.randomize() with {req.action == JTAG_SEQ_ITEM_ACTION_SHIFT_DR; 
                                      req.length == 32;
                                      req.shift_data == 32'haa;                      
                                    });
    `uvm_info("Sequence","jtag_Sequence_item",UVM_NONE)
    finish_item(req);

  endtask:body
endclass: base_sequence
