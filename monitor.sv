///////////////////////////////////////////////////////////////////////////////
// File:        monitor.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-2
// Description: uvm_monitor class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef MONITOR_SV
    `define MONITOR_SV
class monitor extends uvm_monitor;
//Factory
`uvm_component_utils(monitor)
//Fields
uvm_analysis_port#(transaction) send;
virtual spi_i vif;
transaction tr;
logic [15:0] din;
logic [7:0] dout;
//Constructor
function new(string name = "monitor", uvm_component parent = null);
super.new(name, parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
send = new("send", this);
  tr = transaction::type_id::create("tr",this);
if(!uvm_config_db#(virtual spi_i)::get(this, "", "vif", vif))
`uvm_fatal("MON", "Failed to get virtual interface")
endfunction
//Run Phase
virtual task run_phase(uvm_phase phase);
forever begin
      @(posedge vif.clk);
      
      if(vif.rst)
        begin
        tr.op      = rstdut; 
        `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
        send.write(tr);
        end
        
        
      else begin
        @(posedge vif.clk);
             if(vif.miso && !vif.cs)
               begin
                       tr.op = writed;
                      @(posedge vif.clk);
              
                      for(int i = 0; i < 16 ; i++)
                       begin
                       din[i]  <= vif.miso; 
                       @(posedge vif.clk);
                       end
                       
                       tr.addr = din[7:0];
                       tr.din  = din[15:8];
                       
                      @(posedge vif.op_done);
                     `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d",din[7:0],din[15:8]), UVM_NONE); 
                      send.write(tr);
              end
            else if (!vif.miso && !vif.cs)
              begin
                             tr.op = readd; 
                             @(posedge vif.clk);
                             
                               for(int i = 0; i < 8 ; i++)
                               begin
                               din[i]  <= vif.miso;  
                               @(posedge vif.clk);
                               end
                               tr.addr = din[7:0];
                               
                              @(posedge vif.ready);
                              
                              for(int i = 0; i < 8 ; i++)
                              begin
                              @(posedge vif.clk);
                              dout[i] = vif.mosi;
                              end
                               @(posedge vif.op_done);
                              tr.dout = dout;  
                             `uvm_info("MON", $sformatf("DATA READ addr:%0d data:%0d ",tr.addr,tr.dout), UVM_NONE); 
                             send.write(tr);
           end      
    end
end
   endtask
   endclass
`endif