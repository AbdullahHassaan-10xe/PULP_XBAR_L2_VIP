import env_pkg::*;
import seq_pkg::*;
import uvm_pkg::*;    //added for questa support


`include "uvm_macros.svh"

class base_test extends uvm_test;
    
    `uvm_component_utils(base_test);



    //seqs testcases:
    test_gnt_single_bit_high gnt_single_high;
    test_gnt_single_bit_low gnt_single_low;
    test_gnt_multiple_bits gnt_multiple;
    test_single_write single_write; 
    test_cons_write cons_write;
    test_be_lsb be_lsb;
    test_be_msb be_msb;
    test_single_read single_read;
    test_cons_read cons_read;

    test_single_read_r single_read_r;
    test_cons_read_r cons_read_r;




    scoreboard_xbar_l2 test_sb;

    
    //constructor
    function new(string name = "base_test" , uvm_component parent = null);
        super.new(name , parent);  
    endfunction 
  
  
    
    //environment instance for test
    lint_env  env_instance;
    
    
    //wb interface instance
    virtual master_intf master_if;
    
    //response interface
    virtual slave_intf slave_if; 
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
      
      
        
        if(!uvm_config_db #(virtual master_intf):: get(this, "", "master_if", master_if)) 
          begin
            `uvm_fatal("base_test", "base_test::Failed to get master_if")
          end
        
        if(!uvm_config_db #(virtual slave_intf ):: get(this, "", "slave_if", slave_if)) 
          begin
            `uvm_fatal("base_test", "base_test::Failed to get slave_if")
          end 


        
        gnt_single_high = test_gnt_single_bit_high:: type_id::create("gnt_single_high",this);

        gnt_single_low = test_gnt_single_bit_low:: type_id::create("gnt_single_low",this); 

        gnt_multiple = test_gnt_multiple_bits:: type_id::create("gnt_multiple",this);

        single_write = test_single_write:: type_id::create("single_write",this);

        cons_write = test_cons_write:: type_id::create("cons_write",this);

        be_lsb = test_be_lsb:: type_id:: create ("be_lsb");
        
        be_msb = test_be_msb:: type_id:: create ("be_msb");

        single_read = test_single_read:: type_id:: create ("single_read");

        cons_read = test_cons_read:: type_id:: create ("cons_read");



        single_read_r = test_single_read_r:: type_id:: create ("single_read_r");

        cons_read_r = test_cons_read_r:: type_id:: create ("cons_read_r");


        test_sb = scoreboard_xbar_l2:: type_id::create("test_sb",this);  
        
        env_instance = lint_env::type_id::create("env_instance",this);
        
    endfunction: build_phase

//THe following run-phase need to be commented if we want to test individual tests (coverage)
// for regression and coverage testing run this base_test!!! otherwise run the test directly from the tb_top!!!
    virtual task run_phase (uvm_phase phase);
      
        //run_test("single_bit_high_gnt_test");
        phase.raise_objection(this);
        $display("Objection single_high Started!");
    
        gnt_single_high.start(env_instance.lint_agent_inst.seqr);
        #1000;
        gnt_single_low.start(env_instance.lint_agent_inst.seqr);    
        #1000;
        gnt_multiple.start(env_instance.lint_agent_inst.seqr);
        #1000;
        single_write.start(env_instance.lint_agent_inst.seqr);     
        #1000;
        cons_write.start(env_instance.lint_agent_inst.seqr);  
        #1000;
        be_lsb.start(env_instance.lint_agent_inst.seqr);    
        #1000;
        be_msb.start(env_instance.lint_agent_inst.seqr);          
        #1000;
        fork
        single_read.start(env_instance.lint_agent_inst.seqr); 
        single_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here   
        join
        #1000;
        fork
        cons_read.start(env_instance.lint_agent_inst.seqr); 
        cons_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here            
        join     
        #1000;  
        //gnt_single_high.start(env_instance.lint_agent_inst.seqr);
        //#500;
        //run_test("single_bit_low_gnt_test");
        //gnt_single_low.start(env_instance.lint_agent_inst.seqr); 
        //#1000;

        phase.drop_objection(this);
        $display("Objection Dropped!"); 
        
    endtask
     
    function void end_of_elaboration_phase(uvm_phase phase);
        $display("Topology Report");
        uvm_top.print_topology();
        $display("Topology Done!");
    endfunction


endclass


//test cases

class single_bit_high_gnt_test extends base_test; 
    `uvm_component_utils(single_bit_high_gnt_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
    
        gnt_single_high.start(env_instance.lint_agent_inst.seqr);
        #500;
      
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
        
      endtask

endclass

class single_bit_low_gnt_test extends base_test; 
    `uvm_component_utils(single_bit_low_gnt_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection single_bit_low_gnt Started!");
        
        gnt_single_low.start(env_instance.lint_agent_inst.seqr);
        
        
      #500ns;
        
        $display("Sequence single_bit_low_gnt started!"); 
      
        phase.drop_objection(this);
        $display("Objection single_bit_low_gnt Dropped!"); 
      
    endtask

endclass


class multiple_bits_gnt_test extends base_test; 
    `uvm_component_utils(multiple_bits_gnt_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
      
        gnt_multiple.start(env_instance.lint_agent_inst.seqr);
        
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass


class single_write_test extends base_test; 
    `uvm_component_utils(single_write_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
      
        single_write.start(env_instance.lint_agent_inst.seqr);
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass

class cons_write_test extends base_test; 
    `uvm_component_utils(cons_write_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection cons_write Started!");
      
        cons_write.start(env_instance.lint_agent_inst.seqr);  
        
    
        #500ns;
        
        $display("Sequence cons_write started!"); 
      
        phase.drop_objection(this);
        $display("Objection cons_write Dropped!");   
      
    endtask

endclass

class be_lsb_test extends base_test; 
    `uvm_component_utils(be_lsb_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
      
        be_lsb.start(env_instance.lint_agent_inst.seqr);  
        
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass

class be_msb_test extends base_test; 
    `uvm_component_utils(be_msb_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
      
        be_msb.start(env_instance.lint_agent_inst.seqr);   
        
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass


class single_read_test extends base_test; 
    `uvm_component_utils(single_read_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
    
        single_read.start(env_instance.lint_agent_inst.seqr); 
        single_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here   
        
        
        join
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!");   
      
    endtask

endclass


class cons_read_test extends base_test;   
    `uvm_component_utils(cons_read_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
      
        cons_read.start(env_instance.lint_agent_inst.seqr); 
        cons_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here     
        
        
        join
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass




