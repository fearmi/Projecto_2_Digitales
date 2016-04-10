`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:03:20 04/05/2016 
// Design Name: 
// Module Name:    DEMUX 
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
module DEMUX(
input clk,reset,
input [7:0] dato,
input [3:0] selector,
output reg [7:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9
    );




always @ (posedge clk)
if (reset)
begin
R0 <= 8'b0;
R1 <= 8'b0;
R2 <= 8'b0;
R3 <= 8'b0;
R4 <= 8'b0;
R5 <= 8'b0;
R6 <= 8'b0;
R7 <= 8'b0;
R8 <= 8'b0;
R9 <= 8'b0;
end
else
      case (selector)
         4'b0000: R0 <= dato;
         4'b0001: R1 <= dato;
         4'b0010: R2 <= dato;
         4'b0011: R3 <= dato;
         4'b0100: R4 <= dato;
         4'b0101: R5 <= dato;
         4'b0110: R6 <= dato;
         4'b0111: R7 <= dato;
			4'b1000: R8 <= dato;
			default: R9 <= dato;
      endcase
endmodule
