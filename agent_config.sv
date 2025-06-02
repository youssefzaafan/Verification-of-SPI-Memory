///////////////////////////////////////////////////////////////////////////////
// File:        agent_config.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-2
// Description: uvm_object class implementation to configure the agent
///////////////////////////////////////////////////////////////////////////////
`ifndef AGENT_CONFIG_SV
    `define AGENT_CONFIG_SV
class agent_config extends uvm_object;
//Factory 
`uvm_object_utils(agent_config)
//Constructor
function new(string name = "agent_config");
super.new(name);
endfunction 
  uvm_active_passive_enum is_active = UVM_ACTIVE;
endclass
`endif
