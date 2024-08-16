/*
  Encapsulates all signals of the Jtag connected with the Chiptop module
*/
//  Interface: jtag_if
//
interface jtag_intf();

  import  jtag_pkg::*;
    // Signals
  logic TCK;
  logic TMS;
  logic TDI;
  logic TDO;
  // Clocking blocks for monitor and driver

  
  task automatic wait_clks(input int num);
    repeat (num) @(posedge TCK);
  endtask
    // wait for Number of Negative edge clk
  task automatic wait_clks_neg(input int num);
    repeat (num) @(negedge TCK);
  endtask

    // Accessor class for the driver and the monitor
  class drv_accessor extends driver_accessor;

    // constructor
    function new(input string name = "accessor");
      super.new(name);
    endfunction
      // set the TMS Port 
    function logic set_tms (logic tms);     
        TMS = tms;
        return TMS; 
    endfunction 
      //set the TDI Port
    task set_tdi(logic value);      
        TDI = value; 
    endtask 
      //wait for Number of postive edge clk
    task automatic wait_clks(input int num);
      repeat (num) @(posedge TCK);
    endtask
      // wait for Number of Negative edge clk
    task automatic wait_clks_neg(input int num);
      repeat (num) @(negedge TCK);
    endtask

  endclass: drv_accessor
 
  class mon_accessor extends mointor_accessor;

    // constructor
    function new(input string name = "accessor");
      super.new(name);
    endfunction
      //get the TMS port
    function logic get_tdo();
      return TDO;
    endfunction
      //wait for Number of postive edge clk
    task automatic wait_clks(input int num);
      repeat (num) @(posedge TCK);
    endtask
      // wait for Number of Negative edge clk
    task automatic wait_clks_neg(input int num);
      repeat (num) @(negedge TCK);
    endtask

  endclass: mon_accessor


  // Construct the accessor here and use config_db to set 
  initial 
    begin
      drv_accessor drv_acc;
      mon_accessor mon_acc; 
      drv_acc = new();
      mon_acc = new();
      uvm_config_db#(driver_accessor)::set(null,"*","accessor_drv", drv_acc);
      uvm_config_db#(mointor_accessor)::set(null,"*", "accessor_mon", mon_acc);   
    end 
endinterface: jtag_intf
