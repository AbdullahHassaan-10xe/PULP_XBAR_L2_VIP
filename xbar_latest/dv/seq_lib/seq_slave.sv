import env_pkg::*;



class seq_slave extends uvm_sequence #(seq_item_slave);  

    `uvm_object_utils(seq_slave)
    
  
   //fifo_item an instance of our seq_item_slave 
    seq_item_slave fifo_item; 
     
  
    
    
    function new(string name = "seq_slave");
            super.new(name);
      
    endfunction 


endclass 


class test_single_read_r extends seq_slave; 
`uvm_object_utils(test_single_read_r)
  
    function new (string name = "test_single_read_r");
        super.new(name);
    endfunction
    virtual task body();
     
        fifo_item = seq_item_slave::type_id::create("fifo_item");   
        start_item(fifo_item);
            
          
            //fifo_item.data_r_ID_i[0] = 9'b000000001;  //no point of writing it, slave memory bank is selected by algorithm and not by this

            fifo_item.data_r_rdata_i[0] = 32'h00000001;   

          
        finish_item(fifo_item);
        //#400ns; //this delay not needed when running test
        
    endtask : body
endclass


class test_cons_read_r extends seq_slave; 
`uvm_object_utils(test_cons_read_r)
  
    function new (string name = "test_cons_read_r");
        super.new(name);
    endfunction
    virtual task body();
     
        fifo_item = seq_item_slave::type_id::create("fifo_item");   
        start_item(fifo_item);
            
          
            fifo_item.data_r_rdata_i[0] = 32'h00000001;  

          
        finish_item(fifo_item);
        #100ns;

        start_item(fifo_item);
            
          
            fifo_item.data_r_rdata_i[1] = 32'h00000002;   

          
        finish_item(fifo_item);
        
    endtask : body
endclass



