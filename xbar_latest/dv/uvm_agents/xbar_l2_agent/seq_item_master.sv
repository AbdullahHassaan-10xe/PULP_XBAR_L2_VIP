
    
    
    class seq_item_master extends uvm_sequence_item;

    
          // Req
        bit [8:0]                             data_req_i;             // Data request 
        bit [8:0][13:0]                       data_add_i;                   // Data request Address {memory ROW , BANK} 
        bit [8:0]                             data_wen_i;             // Data request wen : 0--> Store, 1 --> Load
        bit [8:0][31:0]                     data_wdata_i;           // Data request Write data
        bit [8:0][3:0]                         data_be_i;              // Data request Byte enable
        bit [8:0]                             data_gnt_o;             // Data request Grant
        // Resp
        bit [8:0]                         data_r_valid_o;         // Data Response Valid (For LOAD/STORE commands)
        bit [8:0][31:0]                   data_r_rdata_o;         // Data Response DATA (For LOAD commands)   
        bit [3:0]                                chk_sel;                 //this  variable is used to identify the correct check function in scoreboard

    
        //UVM Macros for built-in automation
        
        `uvm_object_utils_begin(seq_item_master) 
            `uvm_field_int(data_req_i,UVM_DEFAULT);
            `uvm_field_int(data_add_i, UVM_DEFAULT);
            `uvm_field_int(data_wen_i,UVM_DEFAULT);
            `uvm_field_int(data_wdata_i,UVM_DEFAULT);
            `uvm_field_int(data_be_i,UVM_DEFAULT);
            `uvm_field_int(data_gnt_o,UVM_DEFAULT);
            `uvm_field_int(data_r_valid_o,UVM_DEFAULT);
            `uvm_field_int(data_r_rdata_o,UVM_DEFAULT);
            `uvm_field_int(chk_sel,UVM_DEFAULT);  
        `uvm_object_utils_end
    
    
            
        

        //  Constructor: new
        function new(string name = "seq_item_master");
            super.new(name);
        endfunction: new


        
    endclass: seq_item_master
    


