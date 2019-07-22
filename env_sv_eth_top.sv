//
// Template for Top module
//
`timescale 1ns/1ps
`ifndef ENV_SV_ETH_TOP__SV
`define ENV_SV_ETH_TOP__SV
`include "eth.v"
`include "defines_eth.v"
`include "../src/wb_sv_eth_intf.sv"

module env_sv_eth_top();

   logic clk;
   logic rst;

   // Clock Generation
   parameter sim_cycle = 10;
   
   // Reset Delay Parameter
   parameter rst_delay = 50;

   always 
      begin
         #(sim_cycle/2) clk = ~clk;
      end

   eth_tx_intf mst_if(clk,rst);
   eth_rx_intf slv_if(clk,rst);
   eth_wb_intf intf_wishbone_t(clk,rst);
   
   env_sv_eth_tb_mod test(); 
   
	logic reset_xgmii_rx_n;
	logic reset_xgmii_tx_n;
	logic clk_xgmii_rx;
	logic clk_xgmii_tx;  

	wire [7:0] xgmii_rxc;
	wire [63:0] xgmii_rxd;
	wire [7:0] xgmii_txc;
	wire [63:0]xgmii_txd;
	

  xge_mac dut (
		.xgmii_txd(xgmii_txd), 
		.xgmii_txc(xgmii_txc), 
		.wb_int_o(intf_wishbone_t.wb_int_o), 
		.wb_dat_o(intf_wishbone_t.wb_dat_o), 
		.wb_ack_o(intf_wishbone_t.wb_ack_o), 
		.pkt_tx_full(mst_if.pkt_tx_full),
	    .pkt_rx_val(slv_if.pkt_rx_val), 
		.pkt_rx_sop(slv_if.pkt_rx_sop), 
		.pkt_rx_mod(slv_if.pkt_rx_mod), 		
		.pkt_rx_err(slv_if.pkt_rx_err), 	
		.pkt_rx_eop(slv_if.pkt_rx_eop), 
		.pkt_rx_data(slv_if.pkt_rx_data),
		.pkt_rx_avail(slv_if.pkt_rx_avail), 	
		.xgmii_rxd(xgmii_rxd), 
		.xgmii_rxc(xgmii_rxc), 
		.wb_we_i(intf_wishbone_t.wb_we_i), 
		.wb_stb_i(intf_wishbone_t.wb_stb_i), 
		.wb_rst_i(rst),
		.wb_dat_i(intf_wishbone_t.wb_dat_i), 
		.wb_cyc_i(intf_wishbone_t.wb_cyc_i), 
		.wb_clk_i(clk), 
		.wb_adr_i(intf_wishbone_t.wb_adr_i), 
		.reset_xgmii_tx_n(reset_xgmii_tx_n),
		.reset_xgmii_rx_n(reset_xgmii_rx_n), 
		.reset_156m25_n(!rst),
		.pkt_tx_val(mst_if.pkt_tx_val), 
		.pkt_tx_sop(mst_if.pkt_tx_sop), 
		.pkt_tx_mod(mst_if.pkt_tx_mod),
		.pkt_tx_eop(mst_if.pkt_tx_eop), 
		.pkt_tx_data(mst_if.pkt_tx_data), 
		.pkt_rx_ren(slv_if.pkt_rx_ren), 
		.clk_xgmii_tx(clk_xgmii_tx), 
		.clk_xgmii_rx(clk_xgmii_rx),
	    .clk_156m25(clk)
 );
		assign xgmii_rxc = xgmii_txc;
	    assign xgmii_rxd = xgmii_txd;

   //Driver reset depending on rst_delay
   initial
      begin
         clk = 0;
         rst = 0;
      #1 rst = 1;
         repeat (rst_delay) @(clk);
         rst = 1'b0;
         @(clk);
   end

	initial begin
   // reset_156m25_n = 1'b0;
    reset_xgmii_rx_n = 1'b0;
    reset_xgmii_tx_n = 1'b0;
    #20ns;
   // reset_156m25_n = 1'b1;
    reset_xgmii_rx_n = 1'b1;
    reset_xgmii_tx_n = 1'b1;
	end

	initial begin
    eth_wb_intf.mck.wb_adr_i <= 8'b0;
    eth_wb_intf.mck.wb_cyc_i <= 1'b0;
    eth_wb_intf.mck.wb_dat_i <= 32'b0;
   // eth_wb_intf.mck.wb_rst_i <= 1'b1;
    eth_wb_intf.mck.wb_stb_i <= 1'b0;
    eth_wb_intf.mck.wb_we_i <= 1'b0;
    @(eth_wb_intf.mck);
  //  eth_wb_intf.mck.wb_rst_i <= 1'b0;
	end

	initial begin
    // clk_156m25 <= 1'b0;
    clk_xgmii_rx <= 1'b0;
    clk_xgmii_tx <= 1'b0;
    forever begin
        #3200ps;
        // clk_156m25 <= ~clk_156m25;
        clk_xgmii_rx <= ~clk_xgmii_rx;
        clk_xgmii_tx <= ~clk_xgmii_tx;
    	end
	end

endmodule: env_sv_eth_top

`endif // ENV_SV_ETH_TOP__SV
