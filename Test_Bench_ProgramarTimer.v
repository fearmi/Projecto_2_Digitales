`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:12:39 04/14/2016
// Design Name:   Programar_Timer
// Module Name:   C:/Xilinx/Proyecto_RTC/Test_Bench_ProgramarTimer.v
// Project Name:  Proyecto_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Programar_Timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Bench_ProgramarTimer;

	// Inputs
	reg Clock;
	reg Reset;
	reg Inicie;

	// Outputs
	wire ReadyT;
	wire [3:0] AddRegT;
	wire [7:0] DireccionT;
	wire ADT;
	wire RDT;
	wire WRT;
	wire CST;
	wire SDT;

	// Instantiate the Unit Under Test (UUT)
	Programar_Timer uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.Inicie(Inicie), 
		.ReadyT(ReadyT), 
		.AddRegT(AddRegT), 
		.DireccionT(DireccionT), 
		.ADT(ADT), 
		.RDT(RDT), 
		.WRT(WRT), 
		.CST(CST), 
		.SDT(SDT)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		Inicie = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
	$display ("time\t Clock Reset Inicie Direccion A/D Read Write ChipS LeerDato");	
		$monitor ("%g\t 	 %b    %b     %b      %h	   %b  %b    %b    %b    %b     ",
		$time, Clock, Reset, Inicie, Direccion1, AD,RD,WR,CS,SD);	
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		Inicie = 0;

		#2; Reset = 1;
		#2; Reset = 0; Inicie = 1;
		#760; Inicie = 1; Reset =1;
		#1; $stop;    
       

	end
   always begin
	#1 Clock = ~ Clock; end 
      
endmodule

