`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:19:04 04/10/2016
// Design Name:   vga_sync
// Module Name:   Y:/Desktop/TEC/2016 I Semestre/projecto2/Test_VGA_Sync.v
// Project Name:  projecto2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_sync
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire [9:0] pix_x;
	wire [9:0] pix_y;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.pix_x(pix_x), 
		.pix_y(pix_y)
	);
initial forever #10 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#100;
		
		// Wait 100 ns for global reset to finish
		reset=0;
      
		// Add stimulus here
#100000;
	end
     
endmodule

