module tb_top;
// ChipTop Signals 
wire jtag_TCK;
wire jtag_TMS;
wire jtag_TDI;
wire jtag_TDO;
wire serial_tl_clock;
wire serial_tl_bits_in_ready;
wire serial_tl_bits_in_valid;
wire[31:0] serial_tl_bits_in_bits;
wire serial_tl_bits_out_ready;
wire serial_tl_bits_out_valid;
wire[31:0] serial_tl_bits_out_bits;
wire custom_boot;
bit clock_clock;
bit reset;
wire axi4_mem_0_clock;
wire axi4_mem_0_reset;
wire axi4_mem_0_bits_aw_ready;
wire axi4_mem_0_bits_aw_valid;
wire[3:0]axi4_mem_0_bits_aw_bits_id;
wire[31:0] axi4_mem_0_bits_aw_bits_addr;
wire[7:0]axi4_mem_0_bits_aw_bits_len;
wire[2:0]axi4_mem_0_bits_aw_bits_size;
wire[1:0]axi4_mem_0_bits_aw_bits_burst;
wire axi4_mem_0_bits_aw_bits_lock;
wire[3:0]axi4_mem_0_bits_aw_bits_cache;
wire[2:0]axi4_mem_0_bits_aw_bits_prot;
wire[3:0]axi4_mem_0_bits_aw_bits_qos;
wire axi4_mem_0_bits_w_ready;
wire axi4_mem_0_bits_w_valid;
wire[63:0] axi4_mem_0_bits_w_bits_data;
wire[7:0]axi4_mem_0_bits_w_bits_strb;
wire axi4_mem_0_bits_w_bits_last;
wire axi4_mem_0_bits_b_ready;
wire axi4_mem_0_bits_b_valid;
wire[3:0]axi4_mem_0_bits_b_bits_id;
wire[1:0]axi4_mem_0_bits_b_bits_resp;
wire axi4_mem_0_bits_ar_ready;
wire axi4_mem_0_bits_ar_valid;
wire[3:0]axi4_mem_0_bits_ar_bits_id;
wire[31:0] axi4_mem_0_bits_ar_bits_addr;
wire[7:0]axi4_mem_0_bits_ar_bits_len;
wire[2:0]axi4_mem_0_bits_ar_bits_size;
wire[1:0]axi4_mem_0_bits_ar_bits_burst;
wire axi4_mem_0_bits_ar_bits_lock;
wire[3:0]axi4_mem_0_bits_ar_bits_cache;
wire[2:0]axi4_mem_0_bits_ar_bits_prot;
wire[3:0]axi4_mem_0_bits_ar_bits_qos;
wire axi4_mem_0_bits_r_ready;
wire axi4_mem_0_bits_r_valid;
wire[3:0]axi4_mem_0_bits_r_bits_id;
wire[63:0] axi4_mem_0_bits_r_bits_data;
wire[1:0]axi4_mem_0_bits_r_bits_resp;
wire axi4_mem_0_bits_r_bits_last;
wire uart_0_txd;
wire uart_0_rxd;
logic [3:0] state;





// SOC reset 
initial
    begin 
        reset <= 1;
        #5;
        reset <= 0;
        #2000;
        $finish;
    end
     
initial 
      begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, "+struct", "+packedmda", "+mda", "+all");
      end

// JTAG Interface
    jtag_intf jtag_if();
    
// UVM config db
initial 
        begin
          uvm_config_db#(virtual jtag_intf)::set(null, "*", "jtag_if", jtag_if);
          uvm_config_db#(logic)::set(null, "*", "state", state);
          run_test("jtag_base_test");
        end
// always @(posedge jtag_if.TCK ) begin
//     state <= tb_top.Soc_top.system.dtm.tapIO_controllerInternal.stateMachine.io_currState;
// end

always 
        begin
        #2 jtag_if.TCK <= ~jtag_if.TCK;
        end
// To generate soc clock
always 
        begin
        #5 clock_clock <= ~clock_clock;
        end

// DUT Instantiation
 ChipTop Soc_top(
.jtag_TCK(jtag_if.TCK),
.jtag_TMS(jtag_if.TMS),
.jtag_TDI(jtag_if.TDI),
.jtag_TDO(jtag_if.TDO),
.serial_tl_clock(serial_tl_clock),
.serial_tl_bits_in_ready(serial_tl_bits_in_ready),
.serial_tl_bits_in_valid(serial_tl_bits_in_valid),
.serial_tl_bits_in_bits(serial_tl_bits_in_bits),
.serial_tl_bits_out_ready(serial_tl_bits_out_ready),
.serial_tl_bits_out_valid(serial_tl_bits_out_valid),
.serial_tl_bits_out_bits(serial_tl_bits_out_bits),
.custom_boot(custom_boot),
.clock_clock(clock_clock),
.reset(reset),
.axi4_mem_0_clock(axi4_mem_0_clock),
.axi4_mem_0_reset(axi4_mem_0_reset),
.axi4_mem_0_bits_aw_ready(axi4_mem_0_bits_aw_ready),
.axi4_mem_0_bits_aw_valid(axi4_mem_0_bits_aw_valid),
.axi4_mem_0_bits_aw_bits_id(axi4_mem_0_bits_aw_bits_id),
.axi4_mem_0_bits_aw_bits_addr(axi4_mem_0_bits_aw_bits_addr),
.axi4_mem_0_bits_aw_bits_len(axi4_mem_0_bits_aw_bits_len),
.axi4_mem_0_bits_aw_bits_size(axi4_mem_0_bits_aw_bits_size),
.axi4_mem_0_bits_aw_bits_burst(axi4_mem_0_bits_aw_bits_burst),
.axi4_mem_0_bits_aw_bits_lock(axi4_mem_0_bits_aw_bits_lock),
.axi4_mem_0_bits_aw_bits_cache(axi4_mem_0_bits_aw_bits_cache),
.axi4_mem_0_bits_aw_bits_prot(axi4_mem_0_bits_aw_bits_prot),
.axi4_mem_0_bits_aw_bits_qos(axi4_mem_0_bits_aw_bits_qos),
.axi4_mem_0_bits_w_ready(axi4_mem_0_bits_w_ready),
.axi4_mem_0_bits_w_valid(axi4_mem_0_bits_w_valid),
.axi4_mem_0_bits_w_bits_data(axi4_mem_0_bits_w_bits_data),
.axi4_mem_0_bits_w_bits_strb(axi4_mem_0_bits_w_bits_strb),
.axi4_mem_0_bits_w_bits_last(axi4_mem_0_bits_w_bits_last),
.axi4_mem_0_bits_b_ready(axi4_mem_0_bits_b_ready),
.axi4_mem_0_bits_b_valid(axi4_mem_0_bits_b_valid),
.axi4_mem_0_bits_b_bits_id(axi4_mem_0_bits_b_bits_id),
.axi4_mem_0_bits_b_bits_resp(axi4_mem_0_bits_b_bits_resp),
.axi4_mem_0_bits_ar_ready(axi4_mem_0_bits_ar_ready),
.axi4_mem_0_bits_ar_valid(axi4_mem_0_bits_ar_valid),
.axi4_mem_0_bits_ar_bits_id(axi4_mem_0_bits_ar_bits_id),
.axi4_mem_0_bits_ar_bits_addr(axi4_mem_0_bits_ar_bits_addr),
.axi4_mem_0_bits_ar_bits_len(axi4_mem_0_bits_ar_bits_len),
.axi4_mem_0_bits_ar_bits_size(axi4_mem_0_bits_ar_bits_size),
.axi4_mem_0_bits_ar_bits_burst(axi4_mem_0_bits_ar_bits_burst),
.axi4_mem_0_bits_ar_bits_lock(axi4_mem_0_bits_ar_bits_lock),
.axi4_mem_0_bits_ar_bits_cache(axi4_mem_0_bits_ar_bits_cache),
.axi4_mem_0_bits_ar_bits_prot(axi4_mem_0_bits_ar_bits_prot),
.axi4_mem_0_bits_ar_bits_qos(axi4_mem_0_bits_ar_bits_qos),
.axi4_mem_0_bits_r_ready(axi4_mem_0_bits_r_ready),
.axi4_mem_0_bits_r_valid(axi4_mem_0_bits_r_valid),
.axi4_mem_0_bits_r_bits_id(axi4_mem_0_bits_r_bits_id),
.axi4_mem_0_bits_r_bits_data(axi4_mem_0_bits_r_bits_data),
.axi4_mem_0_bits_r_bits_resp(axi4_mem_0_bits_r_bits_resp),
.axi4_mem_0_bits_r_bits_last(axi4_mem_0_bits_r_bits_last),
.uart_0_txd(uart_0_txd),
.uart_0_rxd(uart_0_rxd));
endmodule
