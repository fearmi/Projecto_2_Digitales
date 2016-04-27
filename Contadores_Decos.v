`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:21 04/10/2016 
// Design Name: 
// Module Name:    Contadores_Decos 
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
module Contadores_Decos(
    input Clock_in,
    input Reset_in,
	 input Format,
    input Up,
    input Dw,
    input STC,
    input MTC,
    input HTC,
    input DF,
    input MF,
    input AF,
    output [7:0] Seg,
	 output [7:0] Min,
    output [7:0] Hr,
    output [7:0] Ds,
    output [7:0] Ms,
    output [7:0] As
    );
wire [5:0] out,out0;
wire [4:0] out1;
wire [4:0] out2;
wire [3:0] out3;
wire [6:0]	out4; 
// Contador para segundos y minutos
Counter_S_M_UpDown Contador_Segundos ( // contador up/down de segundos, va de 0 a 59
    .Clock(Clock_in), 
    .Enable(STC),  
    .Reset(Reset_in), 
    .down(Dw), 
    .up(Up), 
    .out(out)
    );
// Instantiate the module
Deco_S_M BCD_Segundos( //binario a BCD
    .Clock(Clock_in), 
    .Reset(Reset_in), 
    .Ref(out), 
    .Dato_out(Seg)
    );
// Contador para segundos y minutos
Counter_S_M_UpDown Contador_Minutos (// contador up/down de minutos, va de 0 a 59
    .Clock(Clock_in), 
    .Enable(MTC), 
    .Reset(Reset_in), 
    .down(Dw), 
    .up(Up), 
    .out(out0)
    );
// Instantiate the module
Deco_S_M BCD_Minutos ( //binario a BCD
    .Clock(Clock_in), 
    .Reset(Reset_in), 
    .Ref(out0), 
    .Dato_out(Min)
    );

// Instantiate the module
Counter_H_UpDown Contador_Horas (// contador up/down de horas, va de 0 a 23 o de 1am a 0am (12pm)
    .Clock(Clock_in), 
    .Enable(HTC), 
    .Reset(Reset_in), 
    .down(Dw), 
    .up(Up), 
    .out1(out1)
    );
// Instantiate the module
Deco_H BCD_Horas( //binario a BCD
    .Clock(Clock_in), 
    .Reset(Reset_in), 
    .Formato(Format), //depende del formato
    .Ref(out1), 
    .Dato_out(Hr)
    );
// Instantiate the module
Counter_D_UpDown Contador_Dias (// contador up/down dedias, va de 1 a 31
    .Clock(Clock_in), 
    .Enable(DF), 
    .Reset(Reset_in), 
    .down(Dw), 
    .up(Up), 
    .out2(out2)
    );
// Instantiate the module
Deco_Dias BCD_Dias ( //binario a BCD
    .Clock(Clock_in), 
    .Reset(Reset_in), 
    .Ref(out2), 
    .Dato_out(Ds)
    );

// Instantiate the module
Counter_Ms_UpDown Contador_Meses (// contador up/down de meses, va de 1 a 12
    .Clock(Clock_in), 
    .Enable(MF), 
    .Reset(Reset_in), 
    .down(Dw), 
    .up(Up), 
    .out3(out3)
    );
// Instantiate the module
Deco_Mes BCD_Meses ( //binario a BCD
    .Clock(Clock_in), 
    .Reset(Reset_in), 
    .Ref(out3), 
    .Dato_out(Ms)
    );

// Instantiate the module
Counter_Ao_UpDown Contador_Ao (// contador up/down de segundos, va de 00 a 99
    .Clock(Clock_in), 
    .Enable(AF), 
    .Reset(Reset_in), 
    .down(Dw), 
    .up(Up), 
    .out4(out4)
    );
// Instantiate the module
Deco_Ao BCD_Ao ( //binario a BCD
    .Clock(Clock_in), 
    .Reset(Reset_in), 
    .Ref(out4), 
    .Dato_out(As)
    );
endmodule
