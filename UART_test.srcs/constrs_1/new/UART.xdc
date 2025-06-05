## Clock Signal
set_property PACKAGE_PIN E3 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports clock]

## Digit Place Anode Outputs (8 bits)
set_property PACKAGE_PIN J17 [get_ports {digit_place_annode[0]}]
set_property PACKAGE_PIN J18 [get_ports {digit_place_annode[1]}]
set_property PACKAGE_PIN T9  [get_ports {digit_place_annode[2]}]
set_property PACKAGE_PIN J14 [get_ports {digit_place_annode[3]}]
set_property PACKAGE_PIN P14 [get_ports {digit_place_annode[4]}]
set_property PACKAGE_PIN T14 [get_ports {digit_place_annode[5]}]
set_property PACKAGE_PIN K2  [get_ports {digit_place_annode[6]}]
set_property PACKAGE_PIN U13 [get_ports {digit_place_annode[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_place_annode[*]}]



## Segment Anode Outputs (7 bits)
set_property PACKAGE_PIN T10 [get_ports {segments_annode[6]}]
set_property PACKAGE_PIN R10 [get_ports {segments_annode[5]}]
set_property PACKAGE_PIN K16 [get_ports {segments_annode[4]}]
set_property PACKAGE_PIN K13 [get_ports {segments_annode[3]}]
set_property PACKAGE_PIN P15 [get_ports {segments_annode[2]}]
set_property PACKAGE_PIN T11 [get_ports {segments_annode[1]}]
set_property PACKAGE_PIN L18 [get_ports {segments_annode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments_annode[*]}]



## UART RX  Line
set_property PACKAGE_PIN D14 [get_ports UART_RX]
set_property IOSTANDARD LVCMOS33 [get_ports UART_RX]



