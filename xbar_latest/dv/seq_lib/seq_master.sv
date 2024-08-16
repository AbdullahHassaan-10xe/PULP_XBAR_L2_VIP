import env_pkg::*;
//`include "env_pkg.sv"

class seq_master extends uvm_sequence #(seq_item_master);   
    `uvm_object_utils(seq_master)
    //fifo_item an instance of our seq_item_master 
    seq_item_master fifo_item;
        
  
    function new (string name = "seq_master");
        super.new(name);
    endfunction

endclass


class test_gnt_single_bit_high extends seq_master;
`uvm_object_utils(test_gnt_single_bit_high)
  
    function new (string name = "test_gnt_single_bit_high");
        super.new(name);
    endfunction
    virtual task body();
       
        fifo_item = seq_item_master::type_id::create("fifo_item"); 
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; //single bit  

            fifo_item.chk_sel = 4'b0000;
            
          
        finish_item(fifo_item);
        //#400ns; //this delay not needed when running test
        
    endtask : body
endclass

class test_gnt_single_bit_low extends seq_master;
`uvm_object_utils(test_gnt_single_bit_low)
  
    function new (string name = "test_gnt_single_bit_low");
        super.new(name);
    endfunction
    virtual task body();
      
        fifo_item = seq_item_master::type_id::create("fifo_item"); 
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b100000000; //single bit 

            fifo_item.chk_sel = 4'b0001;
            
           
        finish_item(fifo_item);
       // #400ns;
        
    endtask : body
endclass



class test_gnt_multiple_bits extends seq_master;
`uvm_object_utils(test_gnt_multiple_bits)
  
    function new (string name = "test_gnt_multiple_bits");  
        super.new(name);
    endfunction
    virtual task body();
      
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b100000001; //multiple bits (high and low priority)  

            fifo_item.chk_sel = 4'b0010; 
            
          
        finish_item(fifo_item);
        //#400ns;
        
    endtask : body
endclass


class test_single_write extends seq_master;
`uvm_object_utils(test_single_write)
  
    function new (string name = "test_single_write");  
        super.new(name);
    endfunction
    virtual task body();
       
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; 
            fifo_item.data_add_i[0] = 14'b00000000000001;
            fifo_item.data_wen_i[0] = 1'b0; //write enable     
            fifo_item.data_wdata_i[0] = 32'h00000001; 

          
          
        finish_item(fifo_item);
        //#400ns;
        
    endtask : body
endclass


class test_cons_write extends seq_master;
`uvm_object_utils(test_cons_write)
  
    function new (string name = "test_cons_write");  
        super.new(name);
    endfunction
    virtual task body();
      
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; 
            fifo_item.data_add_i[0] = 14'b00000000000001;
            fifo_item.data_wen_i[0] = 1'b0; //write enable     
            fifo_item.data_wdata_i[0] = 32'h00000001;  

     
            
          
        finish_item(fifo_item);
        #100ns
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000010; 
            fifo_item.data_add_i[1] = 14'b00000000000001;
            fifo_item.data_wen_i[1] = 1'b0; //write enable     
            fifo_item.data_wdata_i[1] = 32'h00000002; 

           
            
          
        finish_item(fifo_item);
        //#400ns;
        
    endtask : body
endclass


class test_be_lsb extends seq_master;
`uvm_object_utils(test_be_lsb)
  
    function new (string name = "test_be_lsb");  
        super.new(name);
    endfunction
    virtual task body();
      
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; 
            fifo_item.data_be_i[0][0] = 1'b1;  //byte lsb enable 
          
            
          
        finish_item(fifo_item);
        //#100ns
        
    endtask : body
endclass

class test_be_msb extends seq_master;
`uvm_object_utils(test_be_msb)
  
    function new (string name = "test_be_msb");  
        super.new(name);
    endfunction
    virtual task body();
      
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; 
            fifo_item.data_be_i[0][3] = 1'b1;   //last byte enable
         
            
          
        finish_item(fifo_item);
        //#100ns
        
    endtask : body
endclass


class test_single_read extends seq_master;
`uvm_object_utils(test_single_read)
  
    function new (string name = "test_single_read");  
        super.new(name);
    endfunction
    virtual task body();
      
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; 
            fifo_item.data_add_i[0] = 14'b00000000000001;
            fifo_item.data_wen_i[0] = 1'b1; //write enable     
          
            
          
        finish_item(fifo_item);
        //#100ns
        
    endtask : body
endclass


class test_cons_read extends seq_master;
`uvm_object_utils(test_cons_read)
  
    function new (string name = "test_cons_read");  
        super.new(name);
    endfunction
    virtual task body();
        
        fifo_item = seq_item_master::type_id::create("fifo_item");  
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000001; 
            fifo_item.data_add_i[0] = 14'b00000000000001;
            fifo_item.data_wen_i[0] = 1'b1; //write enable     
            
            
          
        finish_item(fifo_item);
        #100ns
        start_item(fifo_item);
            
          
            fifo_item.data_req_i = 9'b000000010; 
            fifo_item.data_add_i[1] = 14'b00000000000001;
            fifo_item.data_wen_i[1] = 1'b1; //write enable     
           
          
        finish_item(fifo_item);
        
    endtask : body
endclass
