//
// Template for UVM-compliant physical-level monitor
//

`ifndef ETH_MON__SV
`define ETH_MON__SV


typedef class eth_data;
typedef class eth_mon;

class eth_mon_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use a task if callbacks can be blocking


   // Called at start of observed transaction
   virtual function void pre_trans(eth_mon xactor,
                                   eth_data tr);
   endfunction: pre_trans


   // Called before acknowledging a transaction
   virtual function pre_ack(eth_mon xactor,
                            eth_data tr);
   endfunction: pre_ack
   

   // Called at end of observed transaction
   virtual function void post_trans(eth_mon xactor,
                                    eth_data tr);
   endfunction: post_trans

   
   // Callback method post_cb_trans can be used for coverage
   virtual task post_cb_trans(eth_mon xactor,
                              eth_data tr);
   endtask: post_cb_trans

endclass: eth_mon_callbacks

   

class eth_mon extends uvm_monitor;

   uvm_analysis_port #(eth_data) mon_analysis_port;  //TLM analysis port
   typedef virtual eth_tx_intf v_if;
   v_if mon_if;
   // ToDo: Add another class property if required
   extern function new(string name = "eth_mon",uvm_component parent);
   `uvm_register_cb(eth_mon,eth_mon_callbacks);
   `uvm_component_utils_begin(eth_mon)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method

   extern task rcv1pkt(ref eth_data tr);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern protected virtual task tx_monitor();

endclass: eth_mon


function eth_mon::new(string name = "eth_mon",uvm_component parent);
   super.new(name, parent);
   mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void eth_mon::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here

endfunction: build_phase

function void eth_mon::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   uvm_config_db#(v_if)::get(this, "", "mon_if", mon_if);
endfunction: connect_phase

function void eth_mon::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 
   //ToDo: Implement this phase here

endfunction: end_of_elaboration_phase


function void eth_mon::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here

endfunction: start_of_simulation_phase


task eth_mon::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Implement reset here

endtask: reset_phase


task eth_mon::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
endtask:configure_phase


task eth_mon::run_phase(uvm_phase phase);
   super.run_phase(phase);
  // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   fork
      tx_monitor();
   join
  // phase.drop_objection(this);

endtask: run_phase

task automatic eth_mon::rcv1pkt(ref eth_data tr);
	logic done;
	integer i;
    tr = new();
	tr.pkt_data = new[1152]; 
	i = 0;
	begin
	  done = 0;
	  // pkt_rx_ren <= 1'b1;
	  @(mon_if.pck) ;

	  while ((!done)) begin
	    if (mon_if.pck.pkt_tx_val) begin
	      if (mon_if.pck.pkt_tx_sop) begin
		$display("\n\n------------------------");
		$display("Received Packet");
		$display("------------------------");
	      end
	   //   $display("%d", mon_if.pck.pkt_tx_data);
	tr.pkt_data[i] = mon_if.pck.pkt_tx_data;
		i = i+1;

	      if (mon_if.pck.pkt_tx_eop) begin
		done = 1;
		//mon_if.pck.pkt_tx_ren <= 1'b0;
  		$display("------------------------\n\n");
	      end
	     if (mon_if.pck.pkt_tx_eop) begin
		$display("------------------------\n\n");
	      end
	    end
	    @(mon_if.pck) ;
	  end
	 // mon_if.pck.tx_count <= (mon_if.pck.tx_count + 1);
	end
	//tr = tmp;
endtask: rcv1pkt

task eth_mon::tx_monitor();
   forever begin
      eth_data tr;
      // ToDo: Wait for start of transaction

      `uvm_do_callbacks(eth_mon,eth_mon_callbacks,
                    pre_trans(this, tr))
      `uvm_info("env_sv_eth_MONITOR", "Starting transaction...",UVM_LOW)
      // ToDo: Observe first half of transaction

      // ToDo: User need to add monitoring logic and remove $finish
      //`uvm_info("env_sv_eth_MONITOR"," User need to add monitoring logic ",UVM_LOW)
	 // $finish;
		rcv1pkt(tr); 
		
      `uvm_do_callbacks(eth_mon,eth_mon_callbacks,
                    pre_ack(this, tr))
      // ToDo: React to observed transaction with ACK/NAK
      `uvm_info("env_sv_eth_MONITOR", "Completed transaction...",UVM_LOW)
      `uvm_info("env_sv_eth_MONITOR", tr.sprint(),UVM_LOW)
      `uvm_do_callbacks(eth_mon,eth_mon_callbacks,
                    post_trans(this, tr))
      mon_analysis_port.write(tr);
   end
endtask: tx_monitor

`endif // ETH_MON__SV
