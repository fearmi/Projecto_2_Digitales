`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:49:41 04/05/2016
// Design Name:   Leer_RTC
// Module Name:   C:/Xilinx/Proyecto_RTC/Test_Bench_LeerRTC.v
// Project Name:  Proyecto_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Leer_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Bench_LeerRTC;

	// Inputs
	reg Clock;
	reg Reset;
	reg Inicie;

	// Outputs
	wire [7:0] Direccion1;
	wire AD;
	wire RD;
	wire WR;
	wire CS;
	wire SD;

	// Instantiate the Unit Under Test (UUT)
	Leer_RTC uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.Inicie(Inicie), 
		.Direccion1(Direccion1), 
		.AD(AD), 
		.RD(RD), 
		.WR(WR), 
		.CS(CS), 
		.SD(SD)
	);

	initial begin
		$display ("time\t Clock Reset Inicie Direccion A/D Read Write ChipS LeerDato");	
		$monitor ("%g\t 	 %b    %b     %b      %h	   %b  %b    %b    %b    %b     ",
		$time, Clock, Reset, Inicie, Direccion1, AD,RD,WR,CS,SD);	
		// Initialize Inputs
		Clock = 1;
		Reset = 0;
		Inicie = 0;

		
		#2; Reset = 1;
		#2; Reset = 0; Inicie = 1;
		#1000000; Inicie = 1; Reset =1;
		#1; $stop;       
		
	end
   always begin
	#1 Clock = ~ Clock; end
endmodule

