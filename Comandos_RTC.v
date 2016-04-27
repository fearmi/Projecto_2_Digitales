`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:40:12 04/19/2016 
// Design Name: 
// Module Name:    Comandos_RTC 
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
module Comandos_RTC(
    input [1:0] Comnd_in, // señal de seleccion
    output [7:0] Comnd_sal//comando de salida
    );
reg [7:0] Comnd_out;
always @(Comnd_in)
		case(Comnd_in)
			2'd0 : Comnd_out = 8'hf0;//tranferencia de parametros de reloj y timer
			2'd1 : Comnd_out = 8'hf1;//tranferencia de parametros de fechao reloj
			2'd2 : Comnd_out = 8'hf1;//tranferencia de parametros de fecha o reloj
			2'd3 : Comnd_out = 8'h08;//tranferencia de parametros de  timer
			default : Comnd_out = 8'h0f;
		endcase
assign Comnd_sal=Comnd_out;
endmodule
