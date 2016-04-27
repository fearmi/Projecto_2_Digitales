`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:21 04/12/2016 
// Design Name: 
// Module Name:    Mux_Code 
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
module Mux_Code(
    input [7:0] Dato_RTC, // dato del rtc, dato leido
    input [7:0] Dato_Boton, // dato a programar, dato a enviar al rtc
    input Select,// selector
    output [7:0] Dato_vga // dato a mostrar en vga
    );
	 
assign Dato_vga = Select ? Dato_RTC : Dato_Boton; // mux de dato a mostrar

endmodule
