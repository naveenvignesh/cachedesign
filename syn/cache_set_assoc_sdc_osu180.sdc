###################################################################

# Created by write_sdc on Wed Oct 26 02:49:21 2016

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_area 0
create_clock [get_ports clk]  -period 4.4  -waveform {0 2.2}
set_clock_uncertainty 0.25  [get_clocks clk]
set_input_delay -clock clk  0.6  [get_ports gwe]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[15]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[14]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[13]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[12]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[11]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[10]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[9]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[8]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[7]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[6]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[5]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[4]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[3]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[2]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[1]}]
set_input_delay -clock clk  0.6  [get_ports {mem_idata[0]}]
set_input_delay -clock clk  0.6  [get_ports {addr[15]}]
set_input_delay -clock clk  0.6  [get_ports {addr[14]}]
set_input_delay -clock clk  0.6  [get_ports {addr[13]}]
set_input_delay -clock clk  0.6  [get_ports {addr[12]}]
set_input_delay -clock clk  0.6  [get_ports {addr[11]}]
set_input_delay -clock clk  0.6  [get_ports {addr[10]}]
set_input_delay -clock clk  0.6  [get_ports {addr[9]}]
set_input_delay -clock clk  0.6  [get_ports {addr[8]}]
set_input_delay -clock clk  0.6  [get_ports {addr[7]}]
set_input_delay -clock clk  0.6  [get_ports {addr[6]}]
set_input_delay -clock clk  0.6  [get_ports {addr[5]}]
set_input_delay -clock clk  0.6  [get_ports {addr[4]}]
set_input_delay -clock clk  0.6  [get_ports {addr[3]}]
set_input_delay -clock clk  0.6  [get_ports {addr[2]}]
set_input_delay -clock clk  0.6  [get_ports {addr[1]}]
set_input_delay -clock clk  0.6  [get_ports {addr[0]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[15]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[14]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[13]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[12]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[11]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[10]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[9]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[8]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[7]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[6]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[5]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[4]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[3]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[2]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[1]}]
set_output_delay -clock clk  0.3  [get_ports {mem_iaddr[0]}]
set_output_delay -clock clk  0.3  [get_ports valid]
set_output_delay -clock clk  0.3  [get_ports {data[15]}]
set_output_delay -clock clk  0.3  [get_ports {data[14]}]
set_output_delay -clock clk  0.3  [get_ports {data[13]}]
set_output_delay -clock clk  0.3  [get_ports {data[12]}]
set_output_delay -clock clk  0.3  [get_ports {data[11]}]
set_output_delay -clock clk  0.3  [get_ports {data[10]}]
set_output_delay -clock clk  0.3  [get_ports {data[9]}]
set_output_delay -clock clk  0.3  [get_ports {data[8]}]
set_output_delay -clock clk  0.3  [get_ports {data[7]}]
set_output_delay -clock clk  0.3  [get_ports {data[6]}]
set_output_delay -clock clk  0.3  [get_ports {data[5]}]
set_output_delay -clock clk  0.3  [get_ports {data[4]}]
set_output_delay -clock clk  0.3  [get_ports {data[3]}]
set_output_delay -clock clk  0.3  [get_ports {data[2]}]
set_output_delay -clock clk  0.3  [get_ports {data[1]}]
set_output_delay -clock clk  0.3  [get_ports {data[0]}]
