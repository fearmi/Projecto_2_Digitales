`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:57 04/17/2016 
// Design Name: 
// Module Name:    Inicia 
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
module Inicia(input wire Clock, // señales de entrada y salida
    input Reset,
    input Inicie, // señal que permite iniciar el proceso de inicializacion
	 output Ready, // Señal que indica que el proceso ha terminado
	 output [3:0]Reg, // señal que direcciona en registro de datos a programar
    output [7:0]Direc_Dato1, // direccion
	 output ADI,RDI,WRI,CSI,SDI,CMDI // señales de control de rtc (A/D,CS,RD,WR).
    ); // SD permite indicar cuándo enviar el dato y CMD indica cuál comando (F0,F1,F2)
localparam [3:0] a = 4'd0, // Parametros
                      b = 4'd1,
                      c = 4'd2,
                      d = 4'd3,
                      e = 4'd4,
							 f = 4'd5,
							 g = 4'd6,
							 h = 4'd7,
							 i = 4'd8,
							 j = 4'd9,
							 k = 4'd10,
							 l = 4'd11,
							 m = 4'd12,
							 n = 4'd13,
							 o = 4'd14,
							 p = 4'd15;
							 
							 
reg [3:0] state_reg, state_next;
reg [3:0] AddReg; // direccion de reg de datos
wire Fin1, Sent_A1,Sent_D1; // señales de control
reg Ready1,SD,Cmd; // señales de control
reg [7:0]Direc_Dato; // direccion

// Instantiate the module
Escribir_Escribir Write_Write ( // maquina de estados de programacion, se encarga de enviar señales de control
    .Reset(Reset), // su funcion es generar los tiempos necesarios parA el correcto funcionamiento del rtc
    .ciclo(Inicie), // los tiempos se basan en el diagrama de tiempos de INTEL de la hoja de datos del V3023
    .Clock_in(Clock), 
    .A_D1(ADI), 
    .CS1(CSI), 
    .WR1(WRI), 
    .RD1(RDI), 
    .Sent_A1(Sent_A1), // indica cuándo enviar direccion
    .Fin1(Fin1), // señal que indica final de ciclo de dos transferencias de escritura ( escritura de direccion y dato)
    .Sent_D1(Sent_D1)// indica cuándo enviar dato
    );
always @(posedge Clock) // cada flanco positivo de reloj

    if (Reset)
        state_reg <= a;
    else 
        state_reg <= state_next;
//lógica de estado siguiente
always @*
begin // se inicializan variables de salida
    state_next=state_reg;
	 AddReg = 4'h9; // esta posicion lo que contiene es un dato de 8 bits con valor de 0
	 Direc_Dato = 8'h00;
    Ready1 = 1'b0;
	 SD = 1'b0;
	 Cmd = 1'b0;
	 
    case (state_reg)
        a: begin
            if (Inicie) // si le dan permiso, entonces inicia el proce
                state_next = b; 
                 
            else 
                state_next = a;
                
            end
        b: begin // los estados b y c se encargan de hacer el flanco en el bit de inicializacion
            if (Fin1) 
                state_next = c; 
            else if (Sent_A1) begin 
                state_next = b; Direc_Dato = 8'h02;SD = 1'b1;end // direccion registro de status 02
				else if (Sent_D1) begin
                state_next = b; Direc_Dato = 8'h10;SD = 1'b1; end // dato 8'h10, pone bit de inicializacion en alto
				else
					 state_next = b;
            end
        c: begin
            if (Fin1) 
                state_next = d; 
            else if (Sent_A1) begin
                state_next = c; Direc_Dato = 8'h02;SD = 1'b1;end// direccion registro de status 02
				else if (Sent_D1) begin
                state_next = c; Direc_Dato = 8'h00;SD = 1'b1;end// dato 8'h00, pone bit de inicializacion en bajo
				else
					 state_next = c;
            end
            
        d: begin
            if (Fin1) 
                state_next = e; 
            else if (Sent_A1) begin
                state_next = d; Direc_Dato = 8'h10;SD = 1'b1;end// direccion registro de digital trimming
				else if (Sent_D1) begin
                state_next = d; Direc_Dato = 8'hD2;SD = 1'b1;end// se envia D2 como precisión estandar dada en la hoja de datos
				else
					 state_next = d;
            end   
		  e: begin
            if (Fin1) 
                state_next = f; 
            else if (Sent_A1) begin
                state_next = e; Direc_Dato = 8'h01;SD = 1'b1;end// direccion registro de status 01
				else if (Sent_D1) begin
                state_next = e; Direc_Dato = 8'h00;SD = 1'b1;end// dato 8'h00 
				else
					 state_next = e;
            end
		  f: begin
            if (Fin1) 
                state_next = g; 
            else if (Sent_A1) begin
                state_next = f; Direc_Dato = 8'h00;SD = 1'b1;end// direccion registro de status 01
				else if (Sent_D1) begin
                state_next = f; Direc_Dato = 8'h10// dato 8'h10, timer deshabilitado
					 ;SD = 1'b1;end
				else
					 state_next = f;
            end
        g: begin
            if (Fin1) 
                state_next = h; 
            else if (Sent_A1) begin
                state_next = g; Direc_Dato = 8'h21;SD = 1'b1;end// direccion registro 8'h21 segundos de reloj
				else if (Sent_D1) begin
                state_next = g; AddReg = 4'd0;SD=1'b1;end // se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = g;
            end
        h: begin
            if (Fin1) 
                state_next = i; 
            else if (Sent_A1) begin
                state_next = h; Direc_Dato = 8'h22;SD = 1'b1; end// direccion registro 8'h22 minutos de reloj
				else if (Sent_D1) begin
                state_next = h; AddReg=4'd1;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = h;
            end
            
        i: begin
            if (Fin1) 
                state_next = j; 
            else if (Sent_A1) begin
                state_next = i; Direc_Dato = 8'h23;SD = 1'b1;end// direccion registro 8'h23 hora de reloj
				else if (Sent_D1) begin
                state_next = i; AddReg = 4'd2;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = i;
            end   
           		
        j: begin
            if (Fin1) 
                state_next = k; 
            else if (Sent_A1) begin
                state_next = j; Direc_Dato = 8'h24;SD = 1'b1;end// direccion registro 8'h24 día de fecha
				else if (Sent_D1) begin
                state_next = j; AddReg = 4'd3;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = j;
            end
        k: begin
            if (Fin1) 
                state_next = l; 
            else if (Sent_A1) begin
                state_next = k; Direc_Dato = 8'h25;SD = 1'b1;end// direccion registro 8'h25 mes de fecha
				else if (Sent_D1) begin
                state_next = k; AddReg = 4'd4;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = k;
            end
            
        l: begin
            if (Fin1) 
                state_next = m; 
            else if (Sent_A1) begin
                state_next = l; Direc_Dato = 8'h26;SD = 1'b1; end// direccion registro 8'h26 año de fecha
				else if (Sent_D1) begin
                state_next = l; AddReg = 4'd5;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = l;
            end 
        m: begin
            if (Fin1) 
                state_next = n; 
            else if (Sent_A1) begin
                state_next = m; Direc_Dato = 8'h41;SD = 1'b1; end// direccion registro 8'h41 segundos de timer
				else if (Sent_D1) begin
                state_next = m; AddReg = 4'd6;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = m;
            end
        n: begin
            if (Fin1) 
                state_next = o; 
            else if (Sent_A1) begin
                state_next = n; Direc_Dato = 8'h42;SD = 1'b1; end// direccion registro 8'h42 minutos de timer
				else if (Sent_D1) begin
                state_next = n; AddReg = 4'd7;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = n;
            end
        o: begin
            if (Fin1) 
                state_next = p; 
            else if (Sent_A1) begin
                state_next = o; Direc_Dato = 8'h43;SD = 1'b1; end// direccion registro 8'h43 hora de timer
				else if (Sent_D1) begin
                state_next = o; AddReg = 4'd8;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
				else
					 state_next = o;
            end   				
		  p: begin
            if (Fin1) begin 
                state_next = a; Ready1 = 1'b1; end // se envia señal indicando que el proceso de inicializacion ha concluido
            else if (Sent_A1) begin
                state_next = p; Direc_Dato = 8'hF0;SD = 1'b1;end // se envia comando para hacer transferencia de RAM a area reservada
				else if (Sent_D1) begin
                state_next = p; Direc_Dato = 8'hF0;SD=1'b1; Cmd = 1'b1;end // se habilita el envio de comando
				else
					 state_next = p;
            end  				
        default : state_next = a;
    endcase
end // se asignan señales de control y de datos
assign Direc_Dato1 = Direc_Dato;
assign Reg = AddReg;
assign Ready = Ready1;
assign SDI = SD;
assign CMDI = Cmd;
endmodule
