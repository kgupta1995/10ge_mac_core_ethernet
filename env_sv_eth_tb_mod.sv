//
// Template for UVM-compliant Program block

`ifndef ENV_SV_ETH_TB_MOD__SV
`define ENV_SV_ETH_TB_MOD__SV

`include "mstr_slv_intfs.incl"

module env_sv_eth_tb_mod;

import uvm_pkg::*;

`include "env_sv_eth_env.sv"
`include "env_sv_eth_test.sv"  //ToDo: Change this name to the testcase file-name
//`include "test00.sv"
//`include "test01.sv"

// ToDo: Include all other test list here
   typedef virtual eth_tx_intf v_if1;
   typedef virtual eth_rx_intf v_if2;
   initial begin
      uvm_config_db #(v_if1)::set(null,"","mst_if",env_sv_eth_top.mst_if); 
      uvm_config_db #(v_if2)::set(null,"","slv_if",env_sv_eth_top.slv_if);
	  uvm_config_db #(v_if1)::set(null,"","mon_if",env_sv_eth_top.mst_if);
	  uvm_config_db #(v_if2)::set(null,"","mon_if",env_sv_eth_top.slv_if);
      run_test();
   end

endmodule: env_sv_eth_tb_mod

`endif // ENV_SV_ETH_TB_MOD__SV

