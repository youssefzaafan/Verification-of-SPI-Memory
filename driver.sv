///////////////////////////////////////////////////////////////////////////////
// File:        driver.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-2
// Description: uvm_driver class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef DRIVER_SV
    `define DRIVER_SV
class driver extends uvm_driver #(transaction);
//Factory 
`uvm_component_utils(driver)
//Instances 
virtual spi_i vif;
transaction tr;
  logic [15:0] data; ////<- din , addr ->
  logic [7:0] datard;
//Constructor
function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tr = transaction::type_id::create("tr", this);
if(!uvm_config_db#(virtual spi_i)::get(this, "", "vif", vif)) 
`uvm_error("DRV", "Failed to access vif")
endfunction
//Reset Logic
  task reset_dut(); 
    begin
    vif.rst      <= 1'b1;  ///active high reset
    vif.miso     <= 1'b0;
    vif.cs       <= 1'b1;
   `uvm_info("DRV", "System Reset", UVM_MEDIUM);
    @(posedge vif.clk);
    end
  endtask
//Write Logic
task write_dut();
    vif.rst      <= 1'b0;  ///active high reset
    vif.miso     <= 1'b0;
    vif.cs       <= 1'b0;
    data     = {tr.din, tr.addr};
    `uvm_info("DRV", $sformatf("DATA WRITE addr : %0d din : %0d",tr.addr, tr.din), UVM_MEDIUM); 
    @(posedge vif.clk);
    vif.miso <= 1'b1;  ///write operation
    @(posedge vif.clk);
    
    for(int i = 0; i < 16 ; i++)
    begin
    vif.miso <= data[i];
    @(posedge vif.clk);
    end
    @(posedge vif.op_done);
endtask
//Read Logic 
task read_dut();
    vif.rst      <= 1'b0;  ///active high reset
    vif.miso     <= 1'b0;
    vif.cs       <= 1'b0;
    data          = {8'h00, tr.addr};

 @(posedge vif.clk);
  vif.miso <= 1'b0;  ///read operation
  @(posedge vif.clk);
  
  ////send addr
  for(int i = 0; i < 8 ; i++)
   begin
   vif.miso <= data[i];
   @(posedge vif.clk);
   end
   
   ///wait for data ready
  @(posedge vif.ready);
  
  ///sample output data
   for(int i = 0; i < 8 ; i++)
   begin
   @(posedge vif.clk);
   datard[i] = vif.mosi;
   end
   `uvm_info("DRV", $sformatf("DATA READ addr : %0d dout : %0d",tr.addr,datard), UVM_MEDIUM);  
  @(posedge vif.op_done);
  
  endtask 
  
  //////////////////////////
 
  

  virtual task run_phase(uvm_phase phase);
    forever begin
     
         seq_item_port.get_next_item(tr);
     
     
                   if(tr.op ==  rstdut)
                          begin
                          reset_dut();
                          end

                  else if(tr.op == writed)
                          begin
                          write_dut();
                          end
                else if(tr.op ==  readd)
                          begin
					      read_dut();
                          end
                          
       seq_item_port.item_done();
     
   end
  endtask
endclass


`endif