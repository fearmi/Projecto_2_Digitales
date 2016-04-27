`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:43 04/03/2016 
// Design Name: 
// Module Name:    Deco_H 
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
module Deco_H(
	 input Clock,
    input Reset,
	 input Formato,
    input [4:0] Ref,
    output [7:0] Dato_out
    );

reg [7:0] Out;

always @(posedge Clock)

	if (Reset)
		Out <= 8'h00;
	else if (Formato) 
		begin	
		case (Ref)
			5'd0 : Out <= 8'h00;
			5'd1 : Out <= 8'h01;
			5'd2 : Out <= 8'h02;
			5'd3 : Out <= 8'h03;
			5'd4 : Out <= 8'h04;
			5'd5 : Out <= 8'h05;
			5'd6 : Out <= 8'h06;
			5'd7 : Out <= 8'h07;
			5'd8 : Out <= 8'h08;
			5'd9 : Out <= 8'h09;
			5'd10 : Out <= 8'h10;
			5'd11 : Out <= 8'h11;
			5'd12 : Out <= 8'h12;
			5'd13 : Out <= 8'h13;
			5'd14 : Out <= 8'h14;
			5'd15 : Out <= 8'h15;
			5'd16 : Out <= 8'h16;
			5'd17 : Out <= 8'h17;
			5'd18 : Out <= 8'h18;
			5'd19 : Out <= 8'h19;
			5'd20 : Out <= 8'h20;
			5'd21 : Out <= 8'h21;
			5'd22 : Out <= 8'h22;
			5'd23 : Out <= 8'h23;
			5'd24 : Out <= 8'hFF;
		default : Out <= 8'h00;
		endcase
		end
		else
		begin
		case (Ref)
			5'd0 : Out <= 8'h81; // 1 AM
			5'd1 : Out <= 8'h82; // 2 AM 
			5'd2 : Out <= 8'h83; // 3 AM
			5'd3 : Out <= 8'h84; // 4 AM
			5'd4 : Out <= 8'h85; // 5 AM
			5'd5 : Out <= 8'h86; // 6 AM
			5'd6 : Out <= 8'h87; // 7 AM 
			5'd7 : Out <= 8'h88; // 8 AM
			5'd8 : Out <= 8'h89; // 9 AM
			5'd9 : Out <= 8'h90; // 10 AM
			5'd10 : Out <= 8'h91; // 11 AM
			5'd11 : Out <= 8'h12; // 12 AM
			5'd12 : Out <= 8'h01; // 12 PM
			5'd13 : Out <= 8'h02; //1 PM
			5'd14 : Out <= 8'h03; // 2 PM
			5'd15 : Out <= 8'h04; // 3 PM
			5'd16 : Out <= 8'h05; // 4 PM
			5'd17 : Out <= 8'h06; // 5 PM
			5'd18 : Out <= 8'h07; // 6 PM
			5'd19 : Out <= 8'h08; // 7 PM
			5'd20 : Out <= 8'h09; // 8 PM
			5'd21 : Out <= 8'h10; // 9 PM
			5'd22 : Out <= 8'h11; // 10 PM
			5'd23 : Out <= 8'h00; // 11 PM
			5'd24 : Out <= 8'hFF;
		default : Out <= 8'h00;
		endcase
		end
assign Dato_out = Out;
endmodule
