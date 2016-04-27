`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:24 04/10/2016 
// Design Name: 
// Module Name:    DeMux 
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
module DeMux(input clk,reset,
input [7:0] dato, // dato de entrada
input [3:0] selector, // selector de entrada
output reg [7:0] R0,R1,R2,R3,R4,R5,R6,R7,R8 // datos de salida
    );




always @ (posedge clk) // en cada flanco positivo de reloj
if (reset)
begin // inicializa todas los registros en en 8'd0 si hay una señal de reset
R0 <= 8'd0;
R1 <= 8'd0;
R2 <= 8'd0;
R3 <= 8'd0;
R4 <= 8'd0;
R5 <= 8'd0;
R6 <= 8'd0;
R7 <= 8'd0;
R8 <= 8'd0;
end
else
      case (selector)
         4'b0000: R0 <= dato; //segundos_reloj
         4'b0001: R1 <= dato; //minutos_reloj
         4'b0010: R2 <= dato; //hora_reloj
         4'b0011: R3 <= dato; //días_fecha
         4'b0100: R4 <= dato; //meses_fecha
         4'b0101: R5 <= dato; //año_fecha
         4'b0110: R6 <= dato; // segundos timer
         4'b0111: R7 <= dato; // minutos timer
			4'b1000: R8 <= dato; // horas timer
      endcase
endmodule
