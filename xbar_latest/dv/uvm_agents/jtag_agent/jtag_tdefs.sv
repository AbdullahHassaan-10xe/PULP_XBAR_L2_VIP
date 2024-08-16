// this file contains the enum type varible for jtag agent

// Enum type contains the actions items
typedef enum {  
    JTAG_SEQ_ITEM_ACTION_SYNC_RESET,
    JTAG_SEQ_ITEM_ACTION_SHIFT_IR,
    JTAG_SEQ_ITEM_ACTION_SHIFT_DR
} jtag_seq_item_action_enum;
// Instructions Encodings for JTAG 
typedef enum logic [4:0] { 
    BYPASS = 5'h1f,
    IDCODE = 5'h01,
    dtmcs  = 5'h10,
    dmi    = 5'h11
} jtag_seq_item_instr_encd;
// enum for the get_next_state
typedef enum logic [3:0] {
    TEST_LOGIC_RESET = 4'hf ,
    RUN_TEST_IDLE    = 4'hc ,
    SELECT_DR_SCAN   = 4'h7 ,
    CAPTURE_DR       = 4'h6 ,
    SHIFT_DR         = 4'h2 , 
    EXIT1_DR         = 4'h1 ,
    PAUSE_DR         = 4'h3 ,
    EXIT2_DR         = 4'h0 ,
    UPDATE_DR        = 4'h5 ,
    SELECT_IR_SCAN   = 4'h4 ,
    CAPTURE_IR       = 4'he ,
    SHIFT_IR         = 4'ha ,
    EXIT1_IR         = 4'h9 ,
    PAUSE_IR         = 4'hb ,
    EXIT2_IR         = 4'h8 ,
    UPDATE_IR        = 4'hd 
}tap_state_e;// declare states as enum