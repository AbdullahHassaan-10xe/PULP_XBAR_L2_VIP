//`import env_pkg::*;
class scoreboard_xbar_l2 extends uvm_scoreboard;
    `uvm_component_utils(scoreboard_xbar_l2)
    
    uvm_tlm_analysis_fifo #(seq_item_master) inst_test; //port for connecting monitor
    uvm_tlm_analysis_fifo #(seq_item_slave) inst_test_1;

    uvm_tlm_analysis_fifo #(seq_item_master) inst_test_drv; //port for connecting driver

    seq_item_master expected_data;
    seq_item_slave expected_data_slave;
    seq_item_master expected_data1;
    
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
        inst_test = new("inst_test", this);
        inst_test_1 = new("inst_test_1", this);
        inst_test_drv = new("inst_test_drv", this);
    endfunction
    
  
    task run_phase(uvm_phase phase);
        
        `uvm_info(get_type_name(),$sformatf("Into run_phase of scoreboard!"),UVM_LOW)    
        forever begin 
            expected_data = seq_item_master::type_id::create("expected_data");
            expected_data_slave = seq_item_slave::type_id::create("expected_data_slave");
            expected_data1 = seq_item_master::type_id::create("expected_data1");
            
            inst_test.get(expected_data);
            `uvm_info(get_full_name(), $sformatf("\n\nscoreboard_data master:-\n%0s", expected_data.sprint()), UVM_HIGH)
            inst_test_1.get(expected_data_slave);
            `uvm_info(get_full_name(), $sformatf("\n\nscoreboard_data slave:-\n%0s", expected_data_slave.sprint()), UVM_HIGH)
            //inst_test_drv.get(expected_data1);
            //`uvm_info(get_full_name(), $sformatf("\n\nscoreboard_data:-\n%0s", expected_data.sprint()), UVM_HIGH)
            
            //`uvm_info(get_full_name(), $sformatf("\n\nscoreboard_data for chk_sel:-\n%0s", expected_data1.sprint()), UVM_HIGH) 

            /*
            //calling the function
            if (expected_data1.chk_sel == 4'b0000) begin
              single_bit_high_grant(expected_data); 
            end   
            else if (expected_data1.chk_sel == 4'b0001) begin  
              single_bit_low_grant(expected_data);  
            end
            else if (expected_data1.chk_sel == 4'b0010) begin  
              multiple_bits_grant(expected_data);    
            end
            */

            //INVOKING TESTS

            //single_bit_high_grant(expected_data);
            //single_bit_low_grant(expected_data); 
            //multiple_bits_grant(expected_data);
            //single_write(expected_data);
            //cons_write(expected_data);
            //be_lsb(expected_data);
            //be_msb(expected_data);
            //single_read(expected_data, expected_data_slave); 
            //cons_read(expected_data);


        end 
                                 
    endtask

    //CHECK FUNCTIONS: 

    //single_bit_high_priority grant
    
    virtual function void single_bit_high_grant(seq_item_master t);
        //seq_item_master expected_data;
        if(t.data_req_i == t.data_gnt_o) begin//checking the condition
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_req_i,t.data_gnt_o), UVM_NONE) // data display in binary 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_req_i,t.data_gnt_o), UVM_NONE) // data display in binary
        end
        
    endfunction

    //single_bit_low_priority grant
    
    virtual function void single_bit_low_grant(seq_item_master t);
        //seq_item_master expected_data;
        if(t.data_req_i == t.data_gnt_o) begin//checking the condition
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_req_i,t.data_gnt_o), UVM_NONE) // data display in binary 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_req_i,t.data_gnt_o), UVM_NONE) // data display in binary
        end
            
    endfunction

    //multiple_bit_grant (high and low priority bit check)
    virtual function void multiple_bits_grant(seq_item_master t); // no round robin counter, so only 1 request is granted per transaction
        //seq_item_master expected_data;
        if ((t.data_req_i[0] == t.data_gnt_o[0]) && (t.data_req_i[8] != t.data_gnt_o[8])) begin
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_req_i,t.data_gnt_o), UVM_NONE) // data display in binary
        end

        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_req_i,t.data_gnt_o), UVM_NONE) // data display in binary
        end
      
    endfunction


    //single_write
    
    virtual function void single_write(seq_item_master t);
        //seq_item_master expected_data; 
        
        if((t.data_wdata_i[0] == expected_data_slave.data_wdata_o[0]) || (t.data_wdata_i[0] == expected_data_slave.data_wdata_o[1]) || (t.data_wdata_i[0] == expected_data_slave.data_wdata_o[2]) || (t.data_wdata_i[0] == expected_data_slave.data_wdata_o[3]) ) begin//this arrangement refers to the assignment of memory module 2
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",t.data_wdata_i[0],expected_data_slave.data_wdata_o[1]), UVM_NONE) // data display for 2nd slave becuase request_o choses 2nd. (this requires manual info taking from waveform)
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",t.data_wdata_i[0],expected_data_slave.data_wdata_o[1]), UVM_NONE) // data display for 2nd slave becuase request_o choses 2nd. (this requires manual info taking from waveform)
        end
        
    endfunction


    
    //cons_write
    
    virtual function void cons_write(seq_item_master t);
        //seq_item_master expected_data;
        
        if((t.data_wdata_i[0] == expected_data_slave.data_wdata_o[0]) || (t.data_wdata_i[0] == expected_data_slave.data_wdata_o[1]) || (t.data_wdata_i[0] == expected_data_slave.data_wdata_o[2]) || (t.data_wdata_i[0] == expected_data_slave.data_wdata_o[3]) 
         || (t.data_wdata_i[1] == expected_data_slave.data_wdata_o[0]) || (t.data_wdata_i[1] == expected_data_slave.data_wdata_o[1]) || (t.data_wdata_i[1] == expected_data_slave.data_wdata_o[2]) || (t.data_wdata_i[1] == expected_data_slave.data_wdata_o[3]) ) begin//this arrangement refers to the assignment of memory module 2
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison for cons_write", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",t.data_wdata_i,expected_data_slave.data_wdata_o), UVM_NONE) // data display for 2nd slave becuase request_o choses 2nd. (this requires manual info taking from waveform)
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison for cons_write", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",t.data_wdata_i,expected_data_slave.data_wdata_o), UVM_NONE) // data display for 2nd slave becuase request_o choses 2nd. (this requires manual info taking from waveform)
        end
    
    endfunction
        
      


        //be_lsb for lsb byte of first request
    
    virtual function void be_lsb(seq_item_master t);
        //seq_item_master expected_data;
        
        if(t.data_be_i[0] == expected_data_slave.data_be_o[0]) begin  
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_be_i[0],expected_data_slave.data_be_o[0]), UVM_NONE) // data display in binary 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_be_i[0],expected_data_slave.data_be_o[0]), UVM_NONE) // data display in binary
        end
        
    endfunction

    
    //be_msb for msb byte of first request

    virtual function void be_msb(seq_item_master t);
        //seq_item_master expected_data;
        
        if(t.data_be_i[0] == expected_data_slave.data_be_o[0]) begin   
            //comparing  
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_be_i[0],expected_data_slave.data_be_o[0]), UVM_NONE) // correct the data display in this info 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%b,actual_data =%b",t.data_be_i[0],expected_data_slave.data_be_o[0]), UVM_NONE) // data display in binary 
        end
        
    endfunction



    //single_read
    
    virtual function void single_read(seq_item_master t, seq_item_slave t1 ); //checking by modifying the function (here no need to check each master as it is appearing on each slave already)
        //seq_item_master expected_data;
        
        if((t1.data_r_rdata_i[0] == t.data_r_rdata_o[0])  ) begin
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",t1.data_r_rdata_i,t.data_r_rdata_o), UVM_NONE) // data display in binary 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",t1.data_r_rdata_i,t.data_r_rdata_o), UVM_NONE) // data display in binary  
        end
        
    endfunction    


    
    //cons_read
    
    virtual function void cons_read(seq_item_master t);
        //seq_item_master expected_data;
        
        if((expected_data_slave.data_r_rdata_i[0] == t.data_r_rdata_o[0] )   ) begin  //checking by modifying the function (here no need to check each master as it is appearing on each slave already)
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",expected_data_slave.data_r_rdata_i,t.data_r_rdata_o), UVM_NONE) // data display in binary 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",expected_data_slave.data_r_rdata_i,t.data_r_rdata_o), UVM_NONE) // data display in binary
        end

        if((expected_data_slave.data_r_rdata_i[1] == t.data_r_rdata_o[0])    ) begin  //checking by modifying the function (here no need to check each master as it is appearing on each slave already)
            //comparing
            `uvm_info("Sb", "Scoreboard has passed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",expected_data_slave.data_r_rdata_i,t.data_r_rdata_o), UVM_NONE) // data display in binary 
        
        end
        else begin
            `uvm_info("Sb", "Scoreboard has failed the Comparison", UVM_NONE)
            `uvm_info(get_full_name(), $sformatf("expected_data=%h,actual_data =%h",expected_data_slave.data_r_rdata_i,t.data_r_rdata_o), UVM_NONE) // data display in binary
        end
        
    endfunction    
        
endclass: scoreboard_xbar_l2 
    
