`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:23 03/29/2016 
// Design Name: 
// Module Name:    Divisor 
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
module Divisor(
input clk_i,
output reg clk_o = 1'b0
    );
always @(posedge clk_i)
begin
clk_o = ~clk_o;
end

endmodule
