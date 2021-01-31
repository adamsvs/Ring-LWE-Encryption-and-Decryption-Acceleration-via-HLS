// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.4
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module knuth_yao_single_zec_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 1;
parameter AWIDTH = 7;
parameter MEM_SIZE = 109;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("./knuth_yao_single_zec_rom.dat", ram);
end



always @(posedge clk)  
begin 
    if (ce0) 
    begin
        q0 <= ram[addr0];
    end
end



endmodule


`timescale 1 ns / 1 ps
module knuth_yao_single_zec(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd1;
parameter AddressRange = 32'd109;
parameter AddressWidth = 32'd7;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



knuth_yao_single_zec_rom knuth_yao_single_zec_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

