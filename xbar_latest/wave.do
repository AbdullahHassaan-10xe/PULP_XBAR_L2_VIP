onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/reset
add wave -noupdate /tb_top/wb_if/clk
add wave -noupdate /tb_top/wb_if/data_req_i
add wave -noupdate /tb_top/wb_if/data_add_i
add wave -noupdate /tb_top/wb_if/data_wen_i
add wave -noupdate /tb_top/wb_if/data_wdata_i
add wave -noupdate /tb_top/wb_if/data_be_i
add wave -noupdate /tb_top/wb_if/data_gnt_o
add wave -noupdate /tb_top/wb_if/data_r_valid_o
add wave -noupdate /tb_top/wb_if/data_r_rdata_o
add wave -noupdate /tb_top/req_resp_if/clk
add wave -noupdate /tb_top/req_resp_if/data_req_o
add wave -noupdate /tb_top/req_resp_if/data_add_o
add wave -noupdate /tb_top/req_resp_if/data_wen_o
add wave -noupdate /tb_top/req_resp_if/data_wdata_o
add wave -noupdate /tb_top/req_resp_if/data_be_o
add wave -noupdate /tb_top/req_resp_if/data_ID_o
add wave -noupdate /tb_top/req_resp_if/data_r_rdata_i
add wave -noupdate /tb_top/req_resp_if/data_r_valid_i
add wave -noupdate /tb_top/req_resp_if/data_r_ID_i
add wave -noupdate /tb_top/DUT_i/data_req_i
add wave -noupdate /tb_top/DUT_i/data_add_i
add wave -noupdate /tb_top/DUT_i/data_wen_i
add wave -noupdate /tb_top/DUT_i/data_wdata_i
add wave -noupdate /tb_top/DUT_i/data_be_i
add wave -noupdate /tb_top/DUT_i/data_gnt_o
add wave -noupdate /tb_top/DUT_i/data_r_valid_o
add wave -noupdate /tb_top/DUT_i/data_r_rdata_o
add wave -noupdate /tb_top/DUT_i/data_req_o
add wave -noupdate /tb_top/DUT_i/data_add_o
add wave -noupdate /tb_top/DUT_i/data_wen_o
add wave -noupdate /tb_top/DUT_i/data_wdata_o
add wave -noupdate /tb_top/DUT_i/data_be_o
add wave -noupdate /tb_top/DUT_i/data_ID_o
add wave -noupdate /tb_top/DUT_i/data_r_rdata_i
add wave -noupdate /tb_top/DUT_i/data_r_valid_i
add wave -noupdate /tb_top/DUT_i/data_r_ID_i
add wave -noupdate /tb_top/DUT_i/clk
add wave -noupdate /tb_top/DUT_i/rst_n
add wave -noupdate /tb_top/DUT_i/data_ID
add wave -noupdate /tb_top/DUT_i/data_add
add wave -noupdate /tb_top/DUT_i/data_routing
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {991 ns}
