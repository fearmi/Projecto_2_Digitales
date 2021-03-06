`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:39 04/11/2016 
// Design Name: 
// Module Name:    Mux_Sig_Control 
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
module Mux_Sig_Control( // mux para seleccionar se�ales de control de lectura o escritura
    input ADR,//lectura
    input ADW,//escritura
    input CSR,//lectura
    input CSW,//escritura
    input RDR,//lectura
    input RDW,//escritura
    input WRR,//lectura
    input WRW,//escritura
    input [7:0] DIR,//lectura
    input [7:0] DIW,//escritura
    output ADf,// se�al de control final
    output CSf,// se�al de control final
    output RDf,// se�al de control final
    output WRf,// se�al de control final
    output [7:0] DIRF,// se�al de control final
    input Sel // selector
    );
// basicamente si el selector es 1 entonces asigna se�ales de lectura, sino de escritura
assign ADf = Sel ? ADR : ADW;
assign CSf = Sel ? CSR : CSW;
assign RDf = Sel ? RDR : RDW;
assign WRf = Sel ? WRR : WRW;
assign DIRF = Sel ? DIR : DIW;
endmodule
