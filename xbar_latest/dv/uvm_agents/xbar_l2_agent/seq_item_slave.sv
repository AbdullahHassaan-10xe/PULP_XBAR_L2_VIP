    class seq_item_slave extends uvm_sequence_item;
   
       // Req --> to Mem
        bit [3:0]                             data_req_o;             // Data request
        bit [3:0][11:0]                       data_add_o;             // Data request Address
        bit [3:0]                             data_wen_o;            // Data request wen : 0--> Store, 1 --> Load
        bit [3:0][31:0]                     data_wdata_o;           // Data request Wrire data
        bit [3:0][3:0]                         data_be_o;              // Data request Byte enable
        bit [3:0][8:0]                         data_ID_o;
        // Resp --> From Mem
        bit [3:0][31:0]                   data_r_rdata_i;         // Data Response DATA (For LOAD commands)
        bit [3:0]                         data_r_valid_i;         // Data Response: Command is Committed
        bit [3:0][8:0]                       data_r_ID_i;            // Data Response ID: To backroute Response    

       
        //UVM Macros for built-in automation
        
        `uvm_object_utils_begin(seq_item_slave) 
            `uvm_field_int(data_req_o,UVM_DEFAULT);
            `uvm_field_int(data_add_o, UVM_DEFAULT);
            `uvm_field_int(data_wen_o,UVM_DEFAULT);
            `uvm_field_int(data_wdata_o,UVM_DEFAULT);
            `uvm_field_int(data_be_o,UVM_DEFAULT);
            `uvm_field_int(data_ID_o,UVM_DEFAULT);
            `uvm_field_int(data_r_rdata_i,UVM_DEFAULT);
            `uvm_field_int(data_r_valid_i,UVM_DEFAULT);
            `uvm_field_int(data_r_ID_i,UVM_DEFAULT);
        `uvm_object_utils_end
    
            
        

        //  Constructor: new
        function new(string name = "seq_item_slave");
            super.new(name);
        endfunction: new


        
    endclass: seq_item_slave
 