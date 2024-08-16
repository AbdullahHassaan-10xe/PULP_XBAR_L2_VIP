import env_pkg::*;

//the virtual sequence

class p_seq extends uvm_sequence;

   `uvm_object_utils(p_seq)
   // sequences
   seq_master master_seq; //the master seq
   test_gnt_single_bit_high single_bit_high;
   test_gnt_single_bit_low single_bit_low;
   test_gnt_multiple_bits multiple_bits; 
   test_single_write single_write;
   test_cons_write cons_write; 
   test_be_lsb be_lsb;
   test_be_msb be_msb;
   test_single_read single_read;
   test_cons_read cons_read;
   

   seq_slave slave_seq; //the slave seq
   test_single_read_r single_read_r;
   test_cons_read_r cons_read_r;
    
  
    `uvm_declare_p_sequencer(p_sequencer)
    
    function new (string name = "p_seq");
        super.new();
        master_seq = seq_master :: type_id :: create ("master_seq");
        single_bit_high = test_gnt_single_bit_high :: type_id :: create ("single_bit_high");
        single_bit_low = test_gnt_single_bit_low :: type_id :: create ("single_bit_low");
        multiple_bits = test_gnt_multiple_bits :: type_id :: create ("multiple_bits");
        single_write = test_single_write :: type_id :: create ("single_write");
        cons_write = test_cons_write :: type_id :: create ("cons_write");
        be_lsb = test_be_lsb :: type_id :: create ("be_lsb");
        be_msb = test_be_msb :: type_id :: create ("be_msb");
        single_read = test_single_read :: type_id :: create ("single_read");
        cons_read = test_cons_read :: type_id :: create ("cons_read");



        slave_seq = seq_slave :: type_id :: create ("slave_seq");
        single_read_r = test_single_read_r :: type_id :: create ("single_read_r");
        cons_read_r = test_cons_read_r :: type_id :: create ("cons_read_r");
      
    endfunction  



    virtual task body();
      
        //execution of the sequences
        //starting the sequences
        fork
        //master_seq.start(p_sequencer.inst_sequencer); 
        single_bit_high.start(p_sequencer.inst_sequencer);
        single_bit_low.start(p_sequencer.inst_sequencer);   
        multiple_bits.start(p_sequencer.inst_sequencer); 
        single_write.start(p_sequencer.inst_sequencer);
        cons_write.start(p_sequencer.inst_sequencer); 
        be_lsb.start(p_sequencer.inst_sequencer);  
        be_msb.start(p_sequencer.inst_sequencer);  
        single_read.start(p_sequencer.inst_sequencer); 
        single_read_r.start(p_sequencer.slave_sequencer); 
        cons_read.start(p_sequencer.inst_sequencer);   
        cons_read_r.start(p_sequencer.slave_sequencer);     
        //slave_seq.start(p_sequencer.slave_sequencer);
        join
      
    endtask


endclass
