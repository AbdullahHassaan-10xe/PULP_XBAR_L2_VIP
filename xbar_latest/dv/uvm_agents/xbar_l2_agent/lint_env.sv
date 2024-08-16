    class lint_env extends uvm_env;
        
        lint_agent lint_agent_inst; //agent class instance

        lint_agent_1 lint_agent_1_inst;
        
        p_sequencer  sequencer_p; //p_sequencer instance

        scoreboard_xbar_l2 main;
        
    `uvm_component_utils(lint_env);
        
        function new(string name = "my_env", uvm_component parent = null);
            super.new(name , parent);
        endfunction:new

        virtual function void build_phase(uvm_phase phase);  
        
            lint_agent_inst = lint_agent :: type_id::create("lint_agent_inst",this);

            lint_agent_1_inst = lint_agent_1 :: type_id::create("lint_agent_1_inst",this);
            
            sequencer_p = p_sequencer ::type_id ::create("sequencer_p",this);

            main = scoreboard_xbar_l2 ::type_id ::create("main",this); 
        endfunction

        virtual function void connect_phase(uvm_phase phase);

            //connecting the sequencers to sequencers instances of agent class 
        
            sequencer_p.inst_sequencer = lint_agent_inst.seqr;
            
            sequencer_p.slave_sequencer = lint_agent_1_inst.r_seqr;   

            lint_agent_inst.mon1.port_item1.connect(main.inst_test.analysis_export);  //connecting mastermonitor to scoreboard

            lint_agent_inst.drv.port_item_chk_sel.connect(main.inst_test_drv.analysis_export);  //connecting master_driver to scoreboard 

            lint_agent_1_inst.mon.port_item.connect(main.inst_test_1.analysis_export); 
              
        endfunction : connect_phase   

    endclass:lint_env 
