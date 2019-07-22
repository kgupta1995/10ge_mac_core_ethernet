/*
//
// Template for UVM-compliant testcase

`ifndef TEST01__SV
`define TEST01__SV


typedef class env_sv_eth_env;

class test01 extends uvm_test;

  `uvm_component_utils(test01)
  env_sv_eth_env env;
  uvm_sequence_library_cfg seq_lib_cfg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = env_sv_eth_env::type_id::create("env", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.*.configure_phase", "default_sequence", null);
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.*.main_phase", "default_sequence", null);
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.master_agent.mast_sqr.main_phase", "default_sequence", sequence_3::get_type());

    

  endfunction

endclass : test01

`endif //TEST__SV

*/

