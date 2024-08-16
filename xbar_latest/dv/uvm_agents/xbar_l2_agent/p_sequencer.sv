    class p_sequencer extends uvm_sequencer;
        
        //it is the virtual sequencer
      
        master_sequencer                   inst_sequencer;  
        slave_sequencer               slave_sequencer;
       
        `uvm_component_utils(p_sequencer)
    function new(string name ,uvm_component parent);
            super.new(name,parent);
        endfunction 
        
    endclass
