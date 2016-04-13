`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:19 03/29/2016 
// Design Name: 
// Module Name:    TOP_VGA 
// Project Name: 
// Target Devices: 
 Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TOP(
input sync, reset,a,
input [7:0] R,//0,//R1,R2,R3,R4,R5,R6,R7,R8,//
output [2:0]rgb,
output hsync,vsync
    );


wire[9:0]pixel_x,pixel_y;

Divisor Divisor_Frec (
    .clk_i(sync), 
    .clk_o(clk_o)
    );
	 
vga_sync Sync (
    .clk(clk_o),  
    .reset(reset), 
    .hsync(hsync), 
    .vsync(vsync), 
    
    .pix_x(pixel_x), 
    .pix_y(pixel_y)
    );
 Generador pixels (
    .clk(clk_o),
		.alarma(a),
		.clock_nexys(sync),	
    .pix_x(pixel_x), 
    .pix_y(pixel_y), 
    .R_Dia_Fecha(R), 
    .R_Mes_Fecha(R), 
    .R_Ano_Fecha(R), 
    .R_Hora_Hora(R), 
    .R_Hora_Minutos(R), 
    .R_Hora_Segundos(R), 
    .R_Cronometro_Hora(R), 
    .R_Cronometro_Minutos(R), 
    .R_Cronometro_Segundo(R), 
    .text_rgb(rgb)
    );








endmodule
