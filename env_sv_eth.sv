//
// Template for UVM-compliant verification environment
//

`ifndef ENV_SV_ETH__SV
`define ENV_SV_ETH__SV




`include "mstr_slv_src.incl"

`include "env_sv_eth_cfg.sv"


`include "scoreboard.sv"

`include "env_sv_eth_cov.sv"

`include "mon_2cov.sv"


// ToDo: Add additional required `include directives

`endif // ENV_SV_ETH__SV
