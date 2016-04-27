`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:26 04/12/2016 
// Design Name: 
// Module Name:    Mux_Code_Reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mux_Code_Reg(
    input [3:0] Code1, // señal para direccionar demux
    input [3:0] Code2,// señal para direccionar demux
    input Select,
    output [3:0] Code_Dmux// señal para direccionar demux final
    );
assign Code_Dmux = Select ? Code1 : Code2; // mux

endmodule
