//  Class: jtag_driver
class jtag_driver extends uvm_driver#(jtag_sequence_item);
  `uvm_component_utils(jtag_driver);

  // TLM Analysis Port
  uvm_analysis_port#(logic [31:0]) ap;
  
  // virtual interface
  driver_accessor accessor;
  virtual jtag_intf jtag_if;

  uvm_event ev; //Step-1. Declaring the event

  //  Constructor: new
  function new(string name = "jtag_driver", uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction: new

  // Standard UVM Methods
  //Interface object being is obtained by doing a get() call on uvm_config_db
  virtual function void build_phase(uvm_phase phase);
    // using the config_db get method to get the virtual interface
    if(!uvm_config_db#(virtual jtag_intf)::get(this,"","jtag_if",jtag_if))begin
      `uvm_fatal("NOVIF",{"Virtual interface must be set for:",get_full_name(),".jtag_if"});
    end 
    // using the config_db get method to get the accessor class handle
    if(!uvm_config_db#(driver_accessor)::get(null,"" ,"accessor_drv", accessor))begin
      `uvm_fatal("No_accessor",{"Accessor must be set for :",get_full_name(),".accessor"});
    end

  endfunction: build_phase

    // Driving sequence item to the dut interface
  virtual task run_phase(uvm_phase phase);
      jtag_sequence_item seq_item;
      phase.raise_objection(this);
     //Step-2. Get the event handle from event pool
      ev = uvm_event_pool::get_global("ev_ab");
      repeat (3) begin
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        seq_item_port.get_next_item(seq_item);
        drv_action(seq_item);
        seq_item_port.item_done();
      end
      phase.drop_objection(this);
      `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
  endtask: run_phase

  // Drive actions to the DUT
  task drv_action(input jtag_sequence_item seq_item);
    logic [4:0] data;
    logic tms;
    static tap_state_e state , next_state;
    case (seq_item.action)
      JTAG_SEQ_ITEM_ACTION_SYNC_RESET: begin
        `uvm_info(get_name(), "Synchronous Reset", UVM_MEDIUM)
        // TMS High for Seq_item.lenght cycles
        accessor.wait_clks(9); 
        for (int i=0; i< seq_item.length; i++ ) 
        begin
            accessor.wait_clks_neg(1);
            tms = accessor.set_tms(1'b1); 
            get_next_state(state , tms , next_state );
            `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
            state = next_state;
          end
        end
      JTAG_SEQ_ITEM_ACTION_SHIFT_IR: begin
          `uvm_info(get_name(), "shift-IR", UVM_NONE)

           // Test-Logic-Reset -> Run_test_Idle        
          accessor.wait_clks_neg(1);
          tms = accessor.set_tms(1'b0);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
          // Run-Test-Idle -> Select-DR-Scan
          accessor.wait_clks_neg(1);
          tms = accessor.set_tms(1'b1);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
          // Select-DR-Scan -> Select-IR-Scan
          accessor.wait_clks_neg(1);
          tms = accessor.set_tms(1'b1);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
          // Select-IR-Scan -> Capture-IR
          accessor.wait_clks_neg(1);
          tms = accessor.set_tms(1'b0);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
          
          // accessor.wait_clks_neg(1);
          // tms = accessor.set_tms(1'b0);
          // get_next_state(state , tms , next_state );
          // `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          // state = next_state;
          // // for (int i=0; i < $size(data); i++ ) begin
          //   accessor.wait_clks_neg(1);
          //   tms = accessor.set_tms(data[i]);
          //   get_next_state(state , tms , next_state );
          //   `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          //   state = next_state;
          // end

          // Instruction shifting into Instruction register Through TDI port
          for (int i = 0; i < seq_item.length ; i++ ) begin
            accessor.wait_clks_neg(1);
            `uvm_info(get_name(), $sformatf("%d and data=%b",i,seq_item.shift_data[i]), UVM_NONE)
            accessor.set_tdi(seq_item.shift_data[i]);
            // Capture-IR -> Shift-IR  and after first iteration we remain in Shift-IR 
            tms = accessor.set_tms(1'b0);
            if(i == 0)
              begin
                get_next_state(state , tms , next_state );
                `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
                state = next_state;
              end
          end
           
          //Shift-IR -> Exit1-IR
          tms = accessor.set_tms(1'b1);
          get_next_state(state ,tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
          // Exit1-IR -> Update-IR
          accessor.wait_clks_neg(1);
          tms = accessor.set_tms(1'b1);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state , tms), UVM_MEDIUM)
          state = next_state;
          // setting the tdi to zero
          accessor.set_tdi(1'b0);
        end
      JTAG_SEQ_ITEM_ACTION_SHIFT_DR: begin
        `uvm_info(get_name(), "shift-DR", UVM_NONE)
         // state transitioning to shift-DR
        // if the starting state is reset
        if (state == TEST_LOGIC_RESET)
          begin  
            `uvm_info(get_name(), "shift-DR with current state Test-Logic Reset", UVM_NONE)
            // Test-Logic-Reset -> Run-Test-Idle
            accessor.wait_clks_neg(1);
            tms = accessor.set_tms(1'b0);           
            get_next_state(state , tms , next_state );
            `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state , tms), UVM_MEDIUM)
            state = next_state;
            // Run-Test-Idle -> Select-DR-Scan
            accessor.wait_clks_neg(1);
            tms = accessor.set_tms(1'b1); 
            get_next_state(state , tms , next_state );
            `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms ), UVM_MEDIUM)
            state = next_state;
            // Select-DR-Scan -> Capture-DR
            accessor.wait_clks_neg(1);
            tms = accessor.set_tms(1'b0);
            get_next_state(state , tms , next_state );
            `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms ), UVM_MEDIUM)
            state = next_state;

            // Data shifting into Data Register through TDI through TDI port
            for (int i = 0; i < seq_item.length; i++ ) 
              begin
                accessor.wait_clks_neg(1);
                `uvm_info(get_name(), $sformatf("%d and data=%b",i,seq_item.shift_data[i]), UVM_NONE)
                accessor.set_tdi(seq_item.shift_data[i]);
                // Capture-DR -> Shift-DR and after first iteration remains in Shift-DR
                tms = accessor.set_tms(1'b0);
                if ( i == 0 )
                  begin
                    get_next_state(state , tms , next_state );
                    `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
                     state = next_state;
                  end
              end
             
            // Shift-DR -> Exit1-DR
            tms = accessor.set_tms(1'b1);
            get_next_state(state , tms , next_state );
            `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
            state = next_state;
            // Exit1-DR -> Update-DR
            accessor.wait_clks_neg(1);
            tms = accessor.set_tms(1'b1);
            get_next_state(state , tms , next_state );
            `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
            state = next_state;
            end
        else if (state == UPDATE_IR)
        begin
          `uvm_info(get_name(), "shift-DR with Update-IR being the current state", UVM_NONE)
           // Update-IR -> Select-DR-Scan
           accessor.wait_clks_neg(1);
           tms = accessor.set_tms (1'b1) ;
           get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
           state = next_state;
           // Select-DR-Scan -> Capture-DR
           accessor.wait_clks_neg(1);
           tms = accessor.set_tms(1'b0);
           get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
           state = next_state;
           // Capture-DR -> Shift-DR
           accessor.wait_clks_neg(1);
           tms = accessor.set_tms (1'b0) ; 
           get_next_state(state , tms , next_state );
           `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
           state = next_state;
           
           `uvm_info(get_type_name(),$sformatf(" Before triggering the event"),UVM_LOW)
        
           //Step-3. Triggering an event
            ev.trigger();
   
           `uvm_info(get_type_name(),$sformatf(" After triggering the event"),UVM_LOW)
           
            // Data shifting into the Data Register
          for (int i = 0; i < seq_item.length + 1 ; i++ ) begin
            accessor.wait_clks_neg(1);
            `uvm_info(get_name(), $sformatf("%d and data=%b",i,seq_item.shift_data[i]), UVM_NONE)
            // Shifting data into the data register selected
            accessor.set_tdi (seq_item.shift_data[i]);
            // TMS set So Remains in the Shift-DR state
            tms = accessor.set_tms (1'b0) ;
            if (i == 0 )
              begin 
                get_next_state(state , tms , next_state );
                `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
                state = next_state;
              end
          end
          ap.write(seq_item.shift_data);
          accessor.set_tdi (1'b0);
          // Shift-DR -> Exit1-DR
          tms = accessor.set_tms(1'b1);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
          // Exit1-DR -> Update-DR
          accessor.wait_clks_neg(1);
          tms = accessor.set_tms(1'b1);
          get_next_state(state , tms , next_state );
          `uvm_info(get_name(), $sformatf("state: %s, next_state: %s, tms: %0d", state ,next_state ,tms), UVM_MEDIUM)
          state = next_state;
        end
      end
  endcase
      //#4;
      `uvm_info(get_name(), "Driver task Drv-action is excuted", UVM_NONE)
  endtask


// Reference model of the State Machine   
  task  get_next_state(input  tap_state_e current_state ,  input logic  tms , output  tap_state_e next_state );     
    @(posedge jtag_if.TCK) 
     case (current_state)
      TEST_LOGIC_RESET: next_state = tms ? TEST_LOGIC_RESET : RUN_TEST_IDLE;
      RUN_TEST_IDLE:    next_state = tms ? SELECT_DR_SCAN : RUN_TEST_IDLE;
      SELECT_DR_SCAN:   next_state = tms ? SELECT_IR_SCAN : CAPTURE_DR;
      CAPTURE_DR:       next_state = tms ? EXIT1_DR : SHIFT_DR;
      SHIFT_DR:         next_state = tms ? EXIT1_DR : SHIFT_DR;
      EXIT1_DR:         next_state = tms ? UPDATE_DR : PAUSE_DR;
      PAUSE_DR:         next_state = tms ? EXIT2_DR : PAUSE_DR;
      EXIT2_DR:         next_state = tms ? UPDATE_DR : SHIFT_DR;
      UPDATE_DR:        next_state = tms ? SELECT_DR_SCAN : RUN_TEST_IDLE;
      SELECT_IR_SCAN:   next_state = tms ? TEST_LOGIC_RESET : CAPTURE_IR;
      CAPTURE_IR:       next_state = tms ? EXIT1_IR : SHIFT_IR;
      SHIFT_IR:         next_state = tms ? EXIT1_IR : SHIFT_IR;
      EXIT1_IR:         next_state = tms ? UPDATE_IR : PAUSE_IR;
      PAUSE_IR:         next_state = tms ? EXIT2_IR : PAUSE_IR;
      EXIT2_IR:         next_state = tms ? UPDATE_IR : SHIFT_IR;
      UPDATE_IR:        next_state = tms ? SELECT_DR_SCAN : RUN_TEST_IDLE;
      default:          next_state = TEST_LOGIC_RESET;
    endcase
  endtask
  

endclass: jtag_driver


