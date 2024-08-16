`define DRIV_IF master_if.master_driver_cb  //the clocking block 


class master_driver extends uvm_driver #(seq_item_master) ;

    `uvm_component_utils(master_driver);

    virtual master_intf master_if;


    uvm_analysis_port #(seq_item_master) port_item_chk_sel;

    //constructor
    function new(string name , uvm_component parent);    
        super.new(name,parent);
    endfunction:new


    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual master_intf):: get(this,"*","master_if",master_if))begin
            `uvm_fatal ("DRIVER","master_driver:Failed to get master_if")
            end

        port_item_chk_sel = new("port_item_chk_sel",this);

    endfunction:build_phase
        
virtual task run_phase (uvm_phase phase);
    

    forever  begin
        //seq_item_master instance
        seq_item_master  inst;
     
        seq_item_port.get_next_item(inst);
        
        `DRIV_IF.data_req_i <= inst.data_req_i;
        `DRIV_IF.data_add_i <= inst.data_add_i; 

        `DRIV_IF.data_wen_i <= inst.data_wen_i; //write enable
        `DRIV_IF.data_wdata_i <= inst.data_wdata_i; 
        `DRIV_IF.data_be_i <= inst.data_be_i;   
        `DRIV_IF.chk_sel <= inst.chk_sel;  
    
        port_item_chk_sel.write(inst); //port for transferring the data
        
    
        `uvm_info(get_full_name(), $sformatf("\n\nmaster_Driver Info:-\n%0s", inst.sprint()), UVM_HIGH)
        
    
        seq_item_port.item_done();
            @(`DRIV_IF);
        
                    
    end
        
endtask
    

endclass : master_driver
