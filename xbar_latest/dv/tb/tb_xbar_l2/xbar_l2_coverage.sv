module xbar_l2_coverage
#(
   parameter N_CH0            = 5,
   parameter N_CH1            = 4,
   parameter ADDR_MEM_WIDTH   = 12,
   parameter N_SLAVE          = 4,
   parameter DATA_WIDTH       = 64,
   parameter BE_WIDTH         = DATA_WIDTH/8,

   parameter ID_WIDTH         = N_CH0+N_CH1,
   parameter N_MASTER         = N_CH0+N_CH1,
   parameter ADDR_IN_WIDTH    = ADDR_MEM_WIDTH+$clog2(N_SLAVE)
)
(
   // ---------------- MASTER CH0+CH1 SIDE  --------------------------
   // Req
   input  logic [N_MASTER-1:0]                             data_req_i,             // Data request
   input  logic [N_MASTER-1:0][ADDR_IN_WIDTH-1:0]          data_add_i,             // Data request Address {memory ROW , BANK}
   input  logic [N_MASTER-1:0]                             data_wen_i,             // Data request wen : 0--> Store, 1 --> Load
   input  logic [N_MASTER-1:0][DATA_WIDTH-1:0]             data_wdata_i,           // Data request Write data
   input  logic [N_MASTER-1:0][BE_WIDTH-1:0]               data_be_i,              // Data request Byte enable
   input logic [N_MASTER-1:0]                             data_gnt_o,             // Data request Grant
   // Resp
   input logic [N_MASTER-1:0]                             data_r_valid_o,         // Data Response Valid (For LOAD/STORE commands)
   input logic [N_MASTER-1:0][DATA_WIDTH-1:0]             data_r_rdata_o,         // Data Response DATA (For LOAD commands)


   // ---------------- MM_SIDE (Interleaved) --------------------------
   // Req --> to Mem
   input  logic [N_SLAVE-1:0]                             data_req_o,             // Data request
   input  logic [N_SLAVE-1:0][ADDR_MEM_WIDTH-1:0]         data_add_o,             // Data request Address
   input  logic [N_SLAVE-1:0]                             data_wen_o ,            // Data request wen : 0--> Store, 1 --> Load
   input  logic [N_SLAVE-1:0][DATA_WIDTH-1:0]             data_wdata_o,           // Data request Wrire data
   input  logic [N_SLAVE-1:0][BE_WIDTH-1:0]               data_be_o,              // Data request Byte enable
   input  logic [N_SLAVE-1:0][ID_WIDTH-1:0]               data_ID_o,
   // Resp --> From Mem
   input   logic [N_SLAVE-1:0][DATA_WIDTH-1:0]             data_r_rdata_i,         // Data Response DATA (For LOAD commands)
   input   logic [N_SLAVE-1:0]                             data_r_valid_i,         // Data Response: Command is Committed
   input   logic [N_SLAVE-1:0][ID_WIDTH-1:0]               data_r_ID_i,            // Data Response ID: To backroute Response

   input  logic                                            clk,                    // Clock
   input  logic                                            rst_n                   // Active Low Reset
);
// Since your coverage module has output logic ports, binding this module may cause it to drive these outputs. So, we did modified the module by changing the output logic ports to input logic if they are only used for observation.

covergroup l2_data_req_i @(posedge clk);
			req_i_coverpoint:coverpoint data_req_i 
            { // Capture specific values
                
                bins all_bin       = {[9'b000000000:9'b100000000]}; // A range bin
                bins odd_values     = {[9'b000000001:9'b111111111]} with (item % 2 == 1'b1); // Odd numbers  : In binary, numbers are odd when their LSB is 1
                bins even_values    = {[9'b000000000:9'b111111110]} with (item % 2 == 1'b0); // Even numbers : In binary, numbers are even when their LSB is 0
        }

endgroup


covergroup l2_data_gnt_o @(posedge clk);
			gnt_o_coverpoint:coverpoint data_gnt_o 
            { // Capture specific values
                bins zero_bin       = {9'b000000000}; // All bits are 0
                bins one_bin        = {9'b000000001}; // Least significant bit is 1
                bins LSB2_bin       = {9'b000000010}; // 2nd Least significant bit is 1
                bins max_value_bin  = {9'b100000000}; // MSB is 1
        }
endgroup


covergroup l2_data_addr @(posedge clk);
			addr_i_coverpoint:coverpoint data_add_i 
            { // Capture specific values
              
                bins one_bin        = {14'b00000000000001}; // Least significant bit is 1
                bins zero_bin        = {14'b00000000000000}; // Least significant bit is 1
        }
endgroup




covergroup l2_data_wen @(posedge clk);
			wen_i_coverpoint:coverpoint data_wen_i 
            { // Capture specific values
              
                bins one_bin        = {1'b1}; // Least significant bit is 1
                bins zero_bin       = {1'b0};
        }
endgroup


covergroup l2_data_wdata @(posedge clk);
			wdata_i_coverpoint:coverpoint data_wdata_i 
            { // Capture specific values
              
                bins one_bin        = {32'h00000001}; // Least significant bit is 1
                bins two_bin       = {32'h00000002};  // least significant bit is 2

        }
endgroup



covergroup l2_data_be @(posedge clk);
			be_i_coverpoint:coverpoint data_be_i 
            { // Capture specific values
              
                bins one_bin        = {4'b0001}; // 1st byte enable for 1st master      
                bins four_bin       = {4'b1000};  // last byte enable for 1st master                                   
        }
endgroup




//cross coverage:
covergroup cross_cover_1 @(posedge clk);  // making it do auto coverage
  			coverpoint data_req_i {
			
		        bins one_bin        = {9'b000000001}; // Least significant bit is 1  //hitting corner point
		        bins LSB2_bin       = {9'b000000010}; // 2nd Least significant bit is 1  
  }
			coverpoint data_gnt_o {
		        bins one_bin        = {9'b000000001}; // Least significant bit is 1  //hitting corner point
		        bins LSB2_bin       = {9'b000000010}; // 2nd Least significant bit is 1
  }
endgroup

covergroup cross_cover_2 @(posedge clk);  // making it do auto coverage
  			coverpoint data_req_i {
		        bins one_bin        = {9'b000000001}; // Least significant bit is 1 
  }
			coverpoint data_add_i {
			bins one_bin        = {14'b00000000000001}; // Least significant bit is 1
  }
  
endgroup

//CROSS COVERAGE WITH CROSSBINS
covergroup cross_cover_3 @(posedge clk);  // making it do auto coverage
                        coverpoint data_gnt_o {
                        bins data_gnt_bins[] = {[9'b000000001:9'b000000010]}; // Define your bins here
                        }
                        coverpoint data_add_i {
                        bins data_add_bins[] = {14'b00000000000001}; // Define your bins here
                        }
                        
                        //cross data_gnt_o, data_add_i; // Cross of two coverpoints, no manual bins needed
                        cross data_gnt_o, data_add_i {
                        //bins crossbin1 = binsof(data_gnt_o) intersect {9'b000000001} && binsof(data_add_i) intersect {14'b00000000000001}; // Example crossbin
                        //another way to check crossbins
                        bins crossbin2 = binsof(data_gnt_o) && binsof(data_add_i); // Example crossbin


                        }
endgroup



	 	initial begin 
			l2_data_req_i inst_req = new();
			l2_data_gnt_o inst_gnt = new();
                        l2_data_addr inst_addr = new();
                        l2_data_wen  inst_wen  = new();
			cross_cover_1 inst_cover_1 = new(); 
			cross_cover_2 inst_cover_2 = new();   
			cross_cover_3 inst_cover_3 = new();  
		end
endmodule
