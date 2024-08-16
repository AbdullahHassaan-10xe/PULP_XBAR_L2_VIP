
import uvm_pkg::*;     //added for questa support
`include "uvm_macros.svh"


`include "base_test.sv";


  module tb_top;


    //clk and reset	
      logic clk,reset;   
     
      initial begin
          clk=0;

          //setting the reset
          reset = 1;
          #20; // Wait for 20 time units
          reset = 0; // Deassert reset
      end
      
      

        //Generate a clock
      always begin
          #10 clk = ~clk;
      end
      
 /*     //for gtkwave
      initial 
          begin
            $dumpfile("sim.vcd");
            $dumpvars; 
          end   

      //for verdi

      initial 
          begin
              $fsdbDumpfile("waves.fsdb");
              $fsdbDumpvars(0, "+struct", "+packedmda", "+mda", "+all");
          end
      
*/   
      //wb interface instance
      master_intf master_if(.clk(clk));
        
      //response interface
      slave_intf slave_if(.clk(clk)); 

      
      //config_db 
      initial begin
      
        
          uvm_config_db#(virtual master_intf ) :: set(null,"*","master_if",master_if); 
          
          uvm_config_db#(virtual slave_intf ) :: set(null,"*","slave_if",slave_if);
          
          
          run_test("base_test");
      end

      
//Parameters to be passed
      
      parameter N_CH0           = 5;  //--> Debug, UdmaTX, UdmaRX, IcacheR5, DataR5
      parameter N_CH1           = 4;  //--> 2xAXI_W, 2X_AXI_R
      parameter N_SLAVE         = 4;
      //parameter N_BRIDGES       = 2;
      parameter ID_WIDTH        = N_CH0+N_CH1;
      parameter N_MASTER        = N_CH0+N_CH1;
      //parameter AUX_WIDTH       = 5;
      parameter ADDR_MEM_WIDTH      = 12;
      parameter DATA_WIDTH      = 32;
      parameter BE_WIDTH        = DATA_WIDTH/8;
      parameter ADDR_IN_WIDTH  = ADDR_MEM_WIDTH+$clog2(N_SLAVE);

    XBAR_L2
    #(
      .N_CH0 (N_CH0),           
      .N_CH1  (N_CH1),          
      .ADDR_MEM_WIDTH (ADDR_MEM_WIDTH),  
      .N_SLAVE    (N_SLAVE),
      .DATA_WIDTH  (DATA_WIDTH),
      .BE_WIDTH    (BE_WIDTH),

      .ID_WIDTH   (ID_WIDTH),
      .N_MASTER   (N_MASTER),
      .ADDR_IN_WIDTH  (ADDR_IN_WIDTH)
    )
    DUT_i
    (
      // ---------------- MASTER CH0+CH1 SIDE  --------------------------
      // Req
    .data_req_i(master_if.data_req_i),             // Data request
    .data_add_i(master_if.data_add_i),             // Data request Address {memory ROW , BANK}
    .data_wen_i(master_if.data_wen_i),             // Data request wen : 0--> Store, 1 --> Load
    .data_wdata_i(master_if.data_wdata_i),           // Data request Write data
    .data_be_i(master_if.data_be_i),              // Data request Byte enable
    .data_gnt_o(master_if.data_gnt_o),             // Data request Grant
      // Resp
    .data_r_valid_o(master_if.data_r_valid_o),         // Data Response Valid (For LOAD/STORE commands)
    .data_r_rdata_o(master_if.data_r_rdata_o),         // Data Response DATA (For LOAD commands)


      // ---------------- MM_SIDE (Interleaved) --------------------------
      // Req --> to Mem
    .data_req_o(slave_if.data_req_o),             // Data request
    .data_add_o(slave_if.data_add_o),             // Data request Address
    .data_wen_o(slave_if.data_wen_o) ,            // Data request wen : 0--> Store, 1 --> Load
    .data_wdata_o(slave_if.data_wdata_o),           // Data request Wrire data
    .data_be_o(slave_if.data_be_o),              // Data request Byte enable
    .data_ID_o(slave_if.data_ID_o),
    // Resp --> From Mem
    .data_r_rdata_i(slave_if.data_r_rdata_i),         // Data Response DATA (For LOAD commands)
    .data_r_valid_i(slave_if.data_r_valid_i),         // Data Response: Command is Committed
    .data_r_ID_i(slave_if.data_r_ID_i),              // Data Response ID: To backroute Response

    .clk(clk),                    // Clock
    .rst_n(reset)                   // Active Low Reset
    );
      



    //Coverage bind: 
    
    //the bind construct is used to insert or "bind" a piece of design or verification code, 
    //such as an instance of a module, interface, or checker, into an existing module or instance without modifying the original source code

    bind XBAR_L2 xbar_l2_coverage xbar_l2_cov(
      .data_req_i(data_req_i),
      .data_add_i(data_add_i),
      .data_wen_i(data_wen_i),
      .data_wdata_i(data_wdata_i),
      .data_be_i(data_be_i),
      .data_gnt_o(data_gnt_o),

      .data_r_valid_o(data_r_valid_o),
      .data_r_rdata_o(data_r_rdata_o),

      .data_req_o(data_req_o),
      .data_add_o(data_add_o),
      .data_wen_o(data_wen_o),
      .data_wdata_o(data_wdata_o),
      .data_be_o(data_be_o),
      .data_ID_o(data_ID_o),

      .data_r_rdata_i(data_r_rdata_i),
      .data_r_valid_i(data_r_valid_i),
      .data_r_ID_i(data_r_ID_i),

      .clk(clk),
      .rst_n(rst_n)
    );

  endmodule:tb_top
