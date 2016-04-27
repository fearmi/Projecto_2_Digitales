`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:09:02 04/05/2016
// Design Name:   Deco_Mes
// Module Name:   C:/Xilinx/Proyecto_RTC/Test_Bench_DecoMes.v
// Project Name:  Proyecto_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Deco_Mes
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Bench_DecoMes;

	// Inputs
	reg Clock;
	reg Reset;
	reg [3:0] Ref;

	// Outputs
	wire [7:0] Dato_out;

	// Instantiate the Unit Under Test (UUT)
	Deco_Mes uut (
		.Clock(Clock), 
		.Reset(Reset),  
		.Ref(Ref), 
		.Dato_out(Dato_out)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		Ref = 0;

		// Wait 100 ns for global reset to finish
		#2;Reset = 1;
		#2; Reset = 0; Ref = 4'd10;
      #2 ; Ref = 4'd0;
		#2; Ref = 4'd1 ;
		#2; Ref = 4'd2 ;
		#2 ;Ref = 4'd3 ;
		#2; Ref = 4'd4 ;
		#2; Ref = 4'd5 ;
		#2; Ref = 4'd6 ;
		#2; Ref = 4'd7 ;
		#2; Ref = 4'd8 ;
		#2; Ref = 4'd9 ;
		#2; Ref = 4'd10 ;
		#2; Ref = 4'd11 ;
		#2; Ref = 4'd1 ;
		#2; Ref = 4'd3 ;
		#2; Ref = 4'd4 ;
		#2; Ref = 4'd5 ;
		#2; Ref = 4'd6 ;
		#2; Ref = 4'd7 ;
		#2; Ref = 4'd8 ;
		#2; Ref = 4'd11 ;
		#2; Ref = 4'd2 ;
		#2; Ref = 4'd8 ;
		#2; Ref = 4'd6 ;
		#2; Ref = 4'd2 ;
		#2; Ref = 4'd11 ;
		#2; Ref = 4'd5 ;
		#2; Ref = 4'd9 ;
		#2; Ref = 4'd11 ;
		#2; Ref = 4'd5 ;
		#2; Ref = 4'd4 ;
		#2; Ref = 4'd3 ;
		# 2; Reset = 1;
		#1; $stop;

	end
      
endmodule

