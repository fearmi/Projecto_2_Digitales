`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:22 04/09/2016 
// Design Name: 
// Module Name:    Control_Rebote 
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
module Control_Rebote(
    input Clock, // señal reloj
	 input Reset, // reset global
    input B_S, // boton 
    input B_B,// boton 
    input B_I,// boton 
    input B_D,// boton 
    input B_OK,I1,I2,I3,// boton  e interruptores
    output Up,// boton salida
    output Down,// boton salida
    output Left,// boton salida
    output Rigth,// boton salida
    output Ok,// boton salida
	 output F0,// interruptor salida
	 output F1,// interruptor salida
	 output F2// interruptor salida
    );
// S e cuenta con varios circuitos antirebote para el control de señales de entrada de botones e interruptores
// Instantiate the module
Antirebote Subir (
    .Boton(B_S), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(Up)
    );
// Instantiate the module
Antirebote Bajar (
    .Boton(B_B), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(Down)
    );
// Instantiate the module
Antirebote Izquierda (
    .Boton(B_I), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(Left)
    );
	 
// Instantiate the module
Antirebote Derecha (
    .Boton(B_D), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(Rigth)
    );
// Instantiate the module
Antirebote Listo (
    .Boton(B_OK), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(Ok)
    );
// Instantiate the module
Antirebote hora (
    .Boton(I1), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(F0)
    );
// Instantiate the module
Antirebote fecha (
    .Boton(I2), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(F1)
    );
// Instantiate the module
Antirebote timer(
    .Boton(I3), 
    .Clock(Clock), 
    .Reset(Reset), 
    .Out_Sinc(F2)
    );
endmodule
