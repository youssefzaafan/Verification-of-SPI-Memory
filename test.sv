///////////////////////////////////////////////////////////////////////////////
// File:        test.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-2
// Description: uvm_test class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef TEST_SV
    `define TEST_SV 
class test extends uvm_test;
//Factory
`uvm_component_utils(test)
//Constructor
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
//Instances
env e;
write_data_sequence wdata;
read_data_sequence rdata;
writeb_readb_sequence wrrdb;
reset_dut_sequence rstdut;  

//Build Phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   e      = env::type_id::create("env",this);
   wdata  = write_data_sequence::type_id::create("wdata");
   rdata  = read_data_sequence::type_id::create("rdata");
   wrrdb  = writeb_readb_sequence::type_id::create("wrrdb");
   rstdut = reset_dut_sequence::type_id::create("rstdut");
endfunction
//Run Phase
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
wrrdb.start(e.ag.sqer);

phase.drop_objection(this);
endtask
endclass
`endif 
