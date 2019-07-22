//
// Template for UVM-compliant testcase

`ifndef TEST__SV
`define TEST__SV

typedef class env_sv_eth_env;

class env_sv_eth_test extends uvm_test;

  `uvm_component_utils(env_sv_eth_test)

  env_sv_eth_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = env_sv_eth_env::type_id::create("env", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.master_agent.mast_sqr.main_phase",
                    "default_sequence", eth_sv_sequencer_sequence_library::get_type()); 
  endfunction

 virtual task main_phase(uvm_phase phase); 
    uvm_objection objection; 
    super.main_phase(phase); 
    objection = phase.get_objection(); 
    objection.set_drain_time(this,1us);
  endtask 



endclass : env_sv_eth_test

`endif //TEST__SV

/*`ifndef UNDERSIZED_PACKET_TEST__SV
`define UNDERSIZED_PACKET_TEST__SV


class undersized_packet_test extends virtual_sequence_test_base;

  `uvm_component_utils( undersized_packet_test )

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $sformatf("Hierarchy: %m"), UVM_NONE )
    factory.set_type_override_by_type(  packet::get_type() ,
                                        packet_undersized::get_type() );
  endfunction : build_phase

endclass : undersized_packet_test */
