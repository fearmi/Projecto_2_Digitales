`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:29 04/11/2016 
// Design Name: 
// Module Name:    Mux_Banco_Reg 
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
module Mux_Banco_Reg( //mux para decidir cuál dato se pasa al banco de registros para ser guardado
    input [7:0] Seg_RT, //el dato se guarda en el banco y así queda almacenado para luego tomarlo y enviarlo
    input [7:0] Min_RT, // al RTC
    input [7:0] Hor_RT,
    input [7:0] Dia,
    input [7:0] Mes,
    input [7:0] Ao,
    output [7:0] Dato_Reg, // dato de salida a banco final
    input [3:0] Selector // selector, misma señal de direccion para banco de registros
    );
reg [7:0]WE1;
   always @(Selector,Seg_RT,Min_RT,Hor_RT,Dia,Mes,Ao) // siempre que haya un cambio en esas variables
      case (Selector)
         4'b0000: WE1 = Seg_RT;
         4'b0001: WE1 = Min_RT;
         4'b0010: WE1 = Hor_RT;
         4'b0011: WE1 = Dia;
			4'b0100: WE1 = Mes;
         4'b0101: WE1 = Ao;
         4'b0110: WE1 = Seg_RT;
         4'b0111: WE1 = Min_RT;
			4'b1000: WE1 = Hor_RT;
			default: WE1 = 8'd0; // caso default
      endcase
					
assign Dato_Reg=WE1;

endmodule
