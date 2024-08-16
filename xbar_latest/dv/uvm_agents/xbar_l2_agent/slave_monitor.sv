`define MON_IF slave_if.slave_monitor_cb

class slave_monitor extends uvm_monitor;

    `uvm_component_utils(slave_monitor)
      
      //virtual interface
    virtual slave_intf slave_if;
      
    uvm_analysis_port #(seq_item_slave) port_item;


    seq_item_slave inst;

 
    function new (string name, uvm_component parent);
        super.new(name, parent);
       
    endfunction

    function void build_phase (uvm_phase phase); 
        super.build_phase(phase);
        $display("Into the slave_monitor build phase!");
      
        if(!uvm_config_db#(virtual slave_intf)::get(this,"","slave_if",slave_if))begin
          `uvm_fatal("NOMEM_IF",{"Virtual interface must be set for:",get_full_name(),".slave_if"});
        end


    
        port_item = new("port_item",this); 
      

    endfunction
 
    virtual task run_phase(uvm_phase phase); 
        inst = seq_item_slave:: type_id :: create("inst", this);

        forever begin 
       
            inst.data_req_o    = `MON_IF.data_req_o;
            inst.data_add_o = `MON_IF.data_add_o;
            inst.data_wen_o    = `MON_IF.data_wen_o;
            inst.data_wdata_o = `MON_IF.data_wdata_o;
            inst.data_be_o = `MON_IF.data_be_o;   
            inst.data_ID_o = `MON_IF.data_ID_o; 
            inst.data_r_rdata_i = `MON_IF.data_r_rdata_i;
            inst.data_r_valid_i = `MON_IF.data_r_valid_i;
            inst.data_r_ID_i = `MON_IF.data_r_ID_i;  


            $display("req_output stored!");

            //writing to the port_item 
			    port_item.write(inst);

            @(`MON_IF);   
       
        end
    
    endtask
  
endclass 