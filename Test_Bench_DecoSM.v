`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:09:42 04/05/2016
// Design Name:   Deco_S_M
// Module Name:   C:/Xilinx/Proyecto_RTC/Test_Bench_DecoSM.v
// Project Name:  Proyecto_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Deco_S_M
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Bench_DecoSM;

	// Inputs
	reg Clock;
	reg Reset;
	reg [5:0] Ref;

	// Outputs
	wire [7:0] Dato_out;

	// Instantiate the Unit Under Test (UUT)
	Deco_S_M uut (
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
		#100;
        
		// Add stimulus here

	end
      
endmodule

