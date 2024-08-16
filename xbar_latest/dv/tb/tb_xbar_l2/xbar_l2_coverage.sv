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
   output logic [N_MASTER-1:0]                             data_gnt_o,             // Data request Grant
   // Resp
   output logic [N_MASTER-1:0]                             data_r_valid_o,         // Data Response Valid (For LOAD/STORE commands)
   output logic [N_MASTER-1:0][DATA_WIDTH-1:0]             data_r_rdata_o,         // Data Response DATA (For LOAD commands)


   // ---------------- MM_SIDE (Interleaved) --------------------------
   // Req --> to Mem
   output  logic [N_SLAVE-1:0]                             data_req_o,             // Data request
   output  logic [N_SLAVE-1:0][ADDR_MEM_WIDTH-1:0]         data_add_o,             // Data request Address
   output  logic [N_SLAVE-1:0]                             data_wen_o ,            // Data request wen : 0--> Store, 1 --> Load
   output  logic [N_SLAVE-1:0][DATA_WIDTH-1:0]             data_wdata_o,           // Data request Wrire data
   output  logic [N_SLAVE-1:0][BE_WIDTH-1:0]               data_be_o,              // Data request Byte enable
   output  logic [N_SLAVE-1:0][ID_WIDTH-1:0]               data_ID_o,
   // Resp --> From Mem
   input   logic [N_SLAVE-1:0][DATA_WIDTH-1:0]             data_r_rdata_i,         // Data Response DATA (For LOAD commands)
   input   logic [N_SLAVE-1:0]                             data_r_valid_i,         // Data Response: Command is Committed
   input   logic [N_SLAVE-1:0][ID_WIDTH-1:0]               data_r_ID_i,            // Data Response ID: To backroute Response

   input  logic                                            clk,                    // Clock
   input  logic                                            rst_n                   // Active Low Reset
);


covergroup l2_data_req_i @(posedge clk);
			req_i_coverpoint:coverpoint data_req_i 
            { // Capture specific values
                bins zero_bin       = {9'b000000000}; // All bits are 0
                bins one_bin        = {9'b000000001}; // Least significant bit is 1
                bins max_value_bin  = {9'b10000000}; // MSB is 1
               // bins upper_half_bin = {[5'b00000, 4'b0001]:[5'b11111, 4'b1111]}; // Upper 4 bits are significant
              //  bins odd_values     = {[9'b000000001:9'b111111111] with (data_req_i[0] == 1'b1)}; // Odd numbers  : In binary, numbers are odd when their LSB is 1
              //  bins even_values    = {[9'b000000000:9'b111111110] with (data_req_i[0] == 1'b0)}; // Even numbers : In binary, numbers are even when their LSB is 0
        }
endgroup


covergroup l2_data_gnt_o @(posedge clk);
			gnt_o_coverpoint:coverpoint data_gnt_o 
            { // Capture specific values
                bins zero_bin       = {9'b000000000}; // All bits are 0
                bins one_bin        = {9'b000000001}; // Least significant bit is 1
                bins max_value_bin  = {9'b10000000}; // MSB is 1
              //  bins upper_half_bin = {[5'b00000, 4'b0001]:[5'b11111, 4'b1111]}; // Upper 4 bits are significant
              //  bins odd_values     = {[9'b000000001:9'b111111111] with (data_req_i[0] == 1'b1)}; // Odd numbers  : In binary, numbers are odd when their LSB is 1
              //  bins even_values    = {[9'b000000000:9'b111111110] with (data_req_i[0] == 1'b0)}; // Even numbers : In binary, numbers are even when their LSB is 0
        }
endgroup


	 	initial begin 
			l2_data_req_i inst_req = new();
			l2_data_gnt_o inst_gnt = new();
		end
endmodule