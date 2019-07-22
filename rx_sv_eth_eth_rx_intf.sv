//
// Template for UVM-compliant interface
//

`ifndef ETH_RX_INTF__SV
`define ETH_RX_INTF__SV

interface eth_rx_intf (input bit clk, input bit rst);

   // ToDo: Define default setup & hold times

   parameter setup_time = 5/*ns*/;
   parameter hold_time  = 3/*ns*/;

   // ToDo: Define synchronous and asynchronous signals as wires

   	logic       async_en;
  	logic       async_rdy;
	logic 		pkt_rx_ren;
	logic 		pkt_rx_avail;
	logic 		[63:0] pkt_rx_data;
	logic 		pkt_rx_eop;
	logic 		pkt_rx_val;
	logic 		pkt_rx_sop;
	logic 		[2:0] pkt_rx_mod;
	logic 		pkt_rx_err;


   // ToDo: Define one clocking block per clock domain
   //       with synchronous signal direction from a
   //       master perspective

   clocking mck @(posedge clk);
      default input #setup_time output #hold_time;

      output pkt_rx_ren;
	  input pkt_rx_err, pkt_rx_mod, pkt_rx_sop, pkt_rx_val, pkt_rx_eop, pkt_rx_data, pkt_rx_avail;

   endclocking: mck

   clocking sck @(posedge clk);
      default input #setup_time output #hold_time;

      // ToDo: List the synchronous signals here

   endclocking: sck

   clocking pck @(posedge clk);
      default input #setup_time output #hold_time;

      input pkt_rx_err, pkt_rx_mod, pkt_rx_sop, pkt_rx_val, pkt_rx_eop, pkt_rx_data, pkt_rx_avail;
output pkt_rx_ren;

   endclocking: pck

   modport master(clocking mck,
                  output async_en,
                  input  async_rdy);

   modport slave(clocking sck,
                 input  async_en,
                 output async_rdy);

   modport passive(clocking pck,
                   input async_en,
                   input async_rdy);

endinterface: eth_rx_intf

`endif // ETH_RX_INTF__SV
