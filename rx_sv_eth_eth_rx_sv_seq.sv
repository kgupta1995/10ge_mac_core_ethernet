//
// Template for UVM-compliant sequencer class
//


`ifndef ETH_RX_SV_SEQ__SV
`define ETH_RX_SV_SEQ__SV


typedef class eth_data;
class eth_rx_sv_seq extends uvm_sequencer # (eth_data);

   `uvm_component_utils(eth_rx_sv_seq)
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 
endclass:eth_rx_sv_seq

`endif // ETH_RX_SV_SEQ__SV
