class jtag_env extends uvm_env;
    
    `uvm_component_utils(jtag_env)
    
    // Variables of Agent and Scoreboard Class
    jtag_agent jtag_agnt;
    JTAG_scoreboard scoreboard_h;
   
    // new - constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
  
    // build_phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      jtag_agnt = jtag_agent::type_id::create("jtag_agnt", this);
      scoreboard_h = JTAG_scoreboard::type_id::create("scoreboard_h",this);
    endfunction : build_phase
    
    // Connect_phase
    // TLM Analysis ports connected with TLM Analysis FIFO of the scoreboard
    function void connect_phase(uvm_phase phase);
        jtag_agnt.driver.ap.connect(scoreboard_h.drv_data_fifo.analysis_export);
        jtag_agnt.monitor.ap.connect(scoreboard_h.mon_data_fifo.analysis_export);
    endfunction : connect_phase
endclass : jtag_env