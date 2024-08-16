`define MON_IF master_if.master_monitor_cb

class master_monitor extends uvm_monitor;

	`uvm_component_utils(master_monitor)
	
	virtual master_intf master_if;
	
	//uvm_analysis_port #(seq_item_master) port_item1;
	uvm_analysis_port #(seq_item_master) port_item1;
	
    //seq_item_master
	seq_item_master inst;

		
	function new (string name, uvm_component parent);
	    super.new(name, parent); 
	
	endfunction
    
    //build phase
	function void build_phase (uvm_phase phase); 
	    super.build_phase(phase);
	    $display("Into the master_monitor build phase!");
	
	if(!uvm_config_db#(virtual master_intf)::get(this,"","master_if",master_if))begin
	    `uvm_fatal("NOMEM_IF",{"Virtual interface must be set for:",get_full_name(),".master_if"});
	end
	
	port_item1 = new("port_item1",this);

	endfunction

    virtual task run_phase(uvm_phase phase); 
    
        inst = seq_item_master:: type_id :: create("inst", this);

        forever begin
            
			//observed signals
			inst = seq_item_master:: type_id :: create("inst", this);  
			inst.data_gnt_o = `MON_IF.data_gnt_o;     
			inst.data_r_valid_o = `MON_IF.data_r_valid_o;
			inst.data_r_rdata_o =`MON_IF.data_r_rdata_o; 
			inst.data_req_i = `MON_IF.data_req_i;
			inst.data_add_i = `MON_IF.data_add_i;
			inst.data_wen_i = `MON_IF.data_wen_i;
			inst.data_wdata_i = `MON_IF.data_wdata_i;
			inst.data_be_i = `MON_IF.data_be_i; 




			`uvm_info(get_full_name(), $sformatf("\n\nmaster_Monitor Info:-\n%0s", inst.sprint()), UVM_HIGH)
			
			//writing to the port_item 1
			port_item1.write(inst);


			 @(`MON_IF); 
          
        end
      
      
    endtask

endclass 

