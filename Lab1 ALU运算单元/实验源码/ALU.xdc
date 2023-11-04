set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {CLK100MHZ}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];

set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports {op[0]}];
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports {op[1]}];

set_property -dict { PACKAGE_PIN  V10 IOSTANDARD LVCMOS33 } [get_ports {A[3]}];
set_property -dict { PACKAGE_PIN  U11 IOSTANDARD LVCMOS33 } [get_ports {A[2]}];
set_property -dict { PACKAGE_PIN  U12 IOSTANDARD LVCMOS33 } [get_ports {A[1]}];
set_property -dict { PACKAGE_PIN  H6 IOSTANDARD LVCMOS33 }  [get_ports {A[0]}];
set_property -dict { PACKAGE_PIN  T13 IOSTANDARD LVCMOS33 } [get_ports {B[3]}];
set_property -dict { PACKAGE_PIN  R16 IOSTANDARD LVCMOS33 } [get_ports {B[2]}];
set_property -dict { PACKAGE_PIN  U8 IOSTANDARD LVCMOS33 } [get_ports {B[1]}];
set_property -dict { PACKAGE_PIN  T8 IOSTANDARD LVCMOS33 } [get_ports {B[0]}];
set_property -dict { PACKAGE_PIN  J17 IOSTANDARD LVCMOS33 } [get_ports {AN[0]}];
set_property -dict { PACKAGE_PIN  J18 IOSTANDARD LVCMOS33 } [get_ports {AN[1]}];
set_property -dict { PACKAGE_PIN T9 IOSTANDARD LVCMOS33 } [get_ports {AN[2]}];
set_property -dict { PACKAGE_PIN  J14 IOSTANDARD LVCMOS33 } [get_ports {AN[3]}];
set_property -dict { PACKAGE_PIN  P14 IOSTANDARD LVCMOS33 } [get_ports {AN[4]}];
set_property -dict { PACKAGE_PIN  T14 IOSTANDARD LVCMOS33 } [get_ports {AN[5]}];
set_property -dict { PACKAGE_PIN  K2 IOSTANDARD LVCMOS33 } [get_ports {AN[6]}];
set_property -dict { PACKAGE_PIN  U13 IOSTANDARD LVCMOS33 } [get_ports {AN[7]}];
set_property -dict { PACKAGE_PIN  T10 IOSTANDARD LVCMOS33 } [get_ports {segment[0]}];
set_property -dict { PACKAGE_PIN  R10 IOSTANDARD LVCMOS33 } [get_ports {segment[1]}];
set_property -dict { PACKAGE_PIN  K16 IOSTANDARD LVCMOS33 } [get_ports {segment[2]}];
set_property -dict { PACKAGE_PIN  K13 IOSTANDARD LVCMOS33 } [get_ports {segment[3]}];
set_property -dict { PACKAGE_PIN  P15 IOSTANDARD LVCMOS33 } [get_ports {segment[4]}];
set_property -dict { PACKAGE_PIN  T11 IOSTANDARD LVCMOS33 } [get_ports {segment[5]}];
set_property -dict { PACKAGE_PIN  L18 IOSTANDARD LVCMOS33 } [get_ports {segment[6]}];
set_property -dict { PACKAGE_PIN  H15 IOSTANDARD LVCMOS33 } [get_ports {DP}];

