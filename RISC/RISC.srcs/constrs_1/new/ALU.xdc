# Cheat sheet :
# Switches:
# R2, T1, U1, W2, R3, T2, T3, V2, W13, W14, V15, W15, W17, W16, V16, V17
# Buttons:
# T18, W19, U18, T17, U17
# LEDs:
# L1, P1, N3, P3, U3, W3, V3, V13, V14, U14, U15, W18, V19, U19, E19, U16

# Define the I/O standard
set_property IOSTANDARD LVCMOS33 [get_ports {inA[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {inB[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {operation[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Dout[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Carry}]
set_property IOSTANDARD LVCMOS33 [get_ports {Overflow}]
set_property IOSTANDARD LVCMOS33 [get_ports {Negatif}]

# Define switches
set_property PACKAGE_PIN R2 [get_ports {inA[0]}]
set_property PACKAGE_PIN T1 [get_ports {inA[1]}]
set_property PACKAGE_PIN U1 [get_ports {inA[2]}]
set_property PACKAGE_PIN W2 [get_ports {inA[3]}]
set_property PACKAGE_PIN R3 [get_ports {inA[4]}]
set_property PACKAGE_PIN T2 [get_ports {inA[5]}]
set_property PACKAGE_PIN T3 [get_ports {inA[6]}]
set_property PACKAGE_PIN V2 [get_ports {inA[7]}]

set_property PACKAGE_PIN W13 [get_ports {inB[0]}]
set_property PACKAGE_PIN W14 [get_ports {inB[1]}]
set_property PACKAGE_PIN V15 [get_ports {inB[2]}]
set_property PACKAGE_PIN W15 [get_ports {inB[3]}]
set_property PACKAGE_PIN W17 [get_ports {inB[4]}]
set_property PACKAGE_PIN V16 [get_ports {inB[5]}]
set_property PACKAGE_PIN V17 [get_ports {inB[6]}]
set_property PACKAGE_PIN T18 [get_ports {inB[7]}]

# Define operation input (3 bits)
set_property PACKAGE_PIN W19 [get_ports {operation[0]}]
set_property PACKAGE_PIN U18 [get_ports {operation[1]}]
set_property PACKAGE_PIN T17 [get_ports {operation[2]}]

# Define outputs
set_property PACKAGE_PIN L1 [get_ports {Dout[0]}]
set_property PACKAGE_PIN P1 [get_ports {Dout[1]}]
set_property PACKAGE_PIN N3 [get_ports {Dout[2]}]
set_property PACKAGE_PIN P3 [get_ports {Dout[3]}]
set_property PACKAGE_PIN U3 [get_ports {Dout[4]}]
set_property PACKAGE_PIN W3 [get_ports {Dout[5]}]
set_property PACKAGE_PIN V3 [get_ports {Dout[6]}]
set_property PACKAGE_PIN V13 [get_ports {Dout[7]}]

# Define carry, overflow, and negative outputs
set_property PACKAGE_PIN U19 [get_ports {Carry}]
set_property PACKAGE_PIN E19 [get_ports {Overflow}]
set_property PACKAGE_PIN U16 [get_ports {Negatif}]

create_clock -period 100.000 -name CLK -waveform {0.000 50.000} [get_ports CLK]
