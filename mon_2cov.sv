//
// Template for UVM-compliant Monitor to Coverage Connector Callbacks
//

`ifndef ETH_MON_2COV_CONNECT
`define ETH_MON_2COV_CONNECT
class eth_mon_2cov_connect extends uvm_component;
   env_sv_eth_cov cov;
   uvm_analysis_export # (eth_data) an_exp;
   `uvm_component_utils(eth_mon_2cov_connect)
   function new(string name="", uvm_component parent=null);
   	super.new(name, parent);
   endfunction: new

   virtual function void write(eth_data tr);
      cov.tr = tr;
      -> cov.cov_event;
   endfunction:write 
endclass: eth_mon_2cov_connect

`endif // ETH_MON_2COV_CONNECT
