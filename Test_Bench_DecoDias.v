`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:47:20 04/05/2016
// Design Name:   Deco_Dias
// Module Name:   C:/Xilinx/Proyecto_RTC/Test_Bench_DecoDias.v
// Project Name:  Proyecto_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Deco_Dias
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Bench_DecoDias;

	// Inputs
	reg Clock;
	reg Reset;
	reg Formato;
	reg [4:0] Ref;

	// Outputs
	wire [7:0] Dato_out;

	// Instantiate the Unit Under Test (UUT)
	Deco_Dias uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.Formato(Formato), 
		.Ref(Ref), 
		.Dato_out(Dato_out)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		Formato = 0;
		Ref = 0;

		// Wait 100 ns for global reset to finish
		#2;Reset = 1;
		#2; Reset = 0; Ref = 5'd10;
      #2 ; Ref = 5'd0;
		#2; Ref = 5'd1 ;
		#2; Ref = 5'd2 ;
		#2 ;Ref = 5'd3 ;
		#2; Ref = 5'd4 ;
		#2; Ref = 5'd5 ;
		#2; Ref = 5'd6 ;
		#2; Ref = 5'd7 ;
		#2; Ref = 5'd8 ;
		#2; Ref = 5'd9 ;
		#2; Ref = 5'd10 ;
		#2; Ref = 5'd11 ;
		#2; Ref = 5'd12 ;
		#2; Ref = 5'd13 ;
		#2; Ref = 5'd14 ;
		#2; Ref = 5'd15 ;
		#2; Ref = 5'd16 ;
		#2; Ref = 5'd17 ;
		#2; Ref = 5'd18 ;
		#2; Ref = 5'd19 ;
		#2; Ref = 5'd20 ;
		#2; Ref = 5'd21 ;
		#2; Ref = 5'd22 ;
		#2; Ref = 5'd23 ;
		#2; Ref = 5'd24 ;
		#2; Ref = 5'd25 ;
		#2; Ref = 5'd26 ;
		#2; Ref = 5'd27 ;
		#2; Ref = 5'd28 ;
		#2; Ref = 5'd29 ;
		#2; Ref = 5'd30 ;
		# 2; Reset = 1;
		#1; $stop;
		// Add stimulus here

	end
	
	always begin 
	#1 Clock = ~ Clock; end
	
	
      
endmodule

