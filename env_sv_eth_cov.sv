//
// Template for UVM-compliant Coverage Class
//

`ifndef ENV_SV_ETH_COV__SV
`define ENV_SV_ETH_COV__SV

class env_sv_eth_cov extends uvm_component;
   event cov_event;
   eth_data tr;
   uvm_analysis_imp #(eth_data, env_sv_eth_cov) cov_export;
   `uvm_component_utils(env_sv_eth_cov)
 
   covergroup cg_trans @(cov_event);
      coverpoint tr.kind;
      // ToDo: Add required coverpoints, coverbins
	TX_ENABLE :   coverpoint env_sv_eth_top.dut.wishbone_if0.cpureg_config0   
		 {   
			bins  enable = {1} ;  
			ignore_bins  unused = {0};   
		 } 

 // INT_PENDING :   coverpoint env_sv_eth_top.dut.wishbone_if0.cpureg_int_pending[8:0] ;  

 STATUS_CRC_ERROR :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_crc_error  
		  {   
			bins  enable = {1} ;  
			ignore_bins  unused = {0};    
		  }    

	 STATUS_FRAGMENT_ERROR :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_fragment_error   
 		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}   

	 STATUS_TXDFIFO_OVFLOW :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_txdfifo_ovflow    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
    
	STATUS_TXDFIFO_UDFLOW :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_txdfifo_udflow    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
 
   	STATUS_RXDFIFO_OVFLOW :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_rxdfifo_ovflow    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
    
	STATUS_RXDFIFO_UDFLOW :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_rxdfifo_udflow    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
    
	 /* STATUS_PAUSE_FRAME_RX :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_pause_frame_rx    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
    
	STATUS_LOCAL_FAULT :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_local_fault    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
    
	STATUS_REMOTE_FAULT :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_remote_fault    
		{      
			bins  enable = {1} ;       
			ignore_bins  unused = {0};    
		}
    	
	STATUS_LENGTH_ERROR :   coverpoint env_sv_eth_top.dut.wishbone_if0.status_lenght_error    
		{      
			bins  enable = {1} ; 
			ignore_bins  unused = {0};    
		}    

	INT_MASK :    coverpoint env_sv_eth_top.dut.wishbone_if0.cpureg_int_mask[8:0] ;   */

	TX_OCTETS :   coverpoint env_sv_eth_top.dut.stats0.stats_tx_octets[31:0]   
		{      
			bins  ten = { [1:10] } ;       
			bins  twenty = { [11:20] } ;       
			bins  thirty = { [21:30] } ;       
			bins  forty = { [31:40] } ;       
			bins  fifty = { [41:50] } ;       
			bins  hundred = {[51:100]} ;       
			bins  thousand = {[101:1000]} ;       
			bins  tenthousand = {[1001:10000]} ;       
			bins  hundredthousand = {[100001:1000000]} ;       
			bins  million = {[1000000:9999999]} ;       
			bins  huge = {[10000000:100000000]} ;    
		}    

	RX_OCTETS :   coverpoint env_sv_eth_top.dut.stats0.stats_rx_octets[31:0]
   		{      
			bins  ten = { [1:10] } ;       
			bins  twenty = { [11:20] } ;       
			bins  thirty = { [21:30] } ;       
			bins  forty = { [31:40] } ;       
			bins  fifty = { [41:50] } ;       
			bins  hundred = {[51:100]} ;       
			bins  thousand = {[101:1000]} ;       
			bins  tenthousand = {[1001:10000]} ;       
			bins  hundredthousand = {[100001:1000000]} ;       
			bins  million = {[1000000:9999999]} ;       
			bins  huge = {[10000000:100000000]} ;    
		}    

	TX_PKTS :     coverpoint env_sv_eth_top.dut.stats0.stats_tx_pkts[31:0]   
		{      
			bins  ten = { [1:10] } ;       
			bins  twenty = { [11:20] } ;       
			bins  thirty = { [21:30] } ;       
			bins  forty = { [31:40] } ;       
			bins  fifty = { [41:50] } ;       
			bins  hundred = {[51:100]} ;       
			bins  thousand = {[101:1000]} ;       
			bins  tenthousand = {[1001:10000]} ;       
			bins  huge = {[10001:1000000]} ;    
		}    

	RX_PKTS :     coverpoint env_sv_eth_top.dut.stats0.stats_rx_pkts[31:0]    
		{      
			bins  ten = { [1:10] } ;       
			bins  twenty = { [11:20] } ;       
			bins  thirty = { [21:30] } ;       
			bins  forty = { [31:40] } ;       
			bins  fifty = { [41:50] } ;       
			bins  hundred = {[51:100]} ;       
			bins  thousand = {[101:1000]} ;       
			bins  tenthousand = {[1001:10000]} ;       
			bins  huge = {[10001:1000000]} ;    
		} 

	/* PKT_LEN :  	coverpoint env_sv_eth_top.eth_data.size()
		{
			bins  ten = { [64:128] };
			bins  twenty = { [129:192]};
			bins  thirty = { [193:256] } ;       
			bins  forty = { [257:320] } ;       
			bins  fifty = { [321:512] } ;       
			bins  hundred = {[513:704]} ;       
			bins  thousand = {[705:1088]} ;       
			bins  tenthousand = {[1089:1536]} ;       
		//	bins  huge = {[10001:1000000]} ;
		} */
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      cov_export = new("Coverage Analysis",this);
   endfunction: new

   virtual function write(eth_data tr);
      this.tr = tr;
      -> cov_event;
   endfunction: write

endclass: env_sv_eth_cov

`endif // ENV_SV_ETH_COV__SV

