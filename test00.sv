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

endclass : undersized_packet_test 

//
// Template for UVM-compliant testcase

`ifndef TEST00__SV
`define TEST00__SV
class sequence_2 extends base_sequence;
  `uvm_object_utils(sequence_2)
  `uvm_add_to_seq_lib(sequence_2,eth_sv_sequencer_sequence_library)

  function new(string name = "seq_2");
    super.new(name);
        `ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
    $display("inside sequence_2" );
    repeat(100) begin
      `uvm_do(req);
        #500; //Dummy delay added here for test run
    end
  endtask
endclass

typedef class env_sv_eth_env;

class test00 extends uvm_test;

  `uvm_component_utils(test00)
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
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.master_agent.mast_sqr.main_phase", "default_sequence", sequence_2::get_type());

    

  endfunction

endclass : test00

`endif //TEST__SV

*/

