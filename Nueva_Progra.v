`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:40 04/19/2016 
// Design Name: 
// Module Name:    Nueva_Progra 
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
module Nueva_Progra( //señales de entrada y salida
 	 input Clock,
    input Reset,
    input Inicie,//señal de inicio
	 output ReadyR,//señal de ready (es decir se ha terminado la programacion)
	 output [3:0]AddRegR,//señal de direccion de banco de registro
    output [7:0]DireccionR, //direccion
	 output ADR,RDR,WRR,CSR,SDR,CMD//señales de control
    );
localparam [2:0] a = 3'd0,
                      b = 3'd1,
                      c = 3'd2,
                      d = 3'd3,
                      e = 3'd4;
							 
reg [2:0] state_reg, state_next;
reg SD,Cmd;
wire Fin1, Sent_A1,Sent_D1;
reg [7:0]Direccion;
reg [3:0] AddReg;
reg Ready;
// Instantiate the module
Escribir_Escribir Write_Write ( //maquina de estados generadora de tiempos de escritura, señales de control
    .Reset(Reset),  // su funcion es generar los tiempos necesarios parA el correcto funcionamiento del rtc
    .ciclo(Inicie), // los tiempos se basan en el diagrama de tiempos de INTEL de la hoja de datos del V3023
    .Clock_in(Clock), 
    .A_D1(ADR), 
    .CS1(CSR), 
    .WR1(WRR), 
    .RD1(RDR), 
    .Sent_A1(Sent_A1),  // indica cuándo enviar direccion
    .Fin1(Fin1), // señal que indica final de ciclo de dos transferencias de escritura ( escritura de direccion y dato)
    .Sent_D1(Sent_D1)// indica cuándo enviar dato
    );
always @(posedge Clock) 

    if (Reset)
        state_reg <= a;
    else 
        state_reg <= state_next;
//lógica de estado siguiente
always @*
begin
    state_next=state_reg;
	 AddReg = 4'h0;
	 Direccion = 8'h00;
    Ready = 1'b0;
	 SD = 1'b0;
	 Cmd = 1'b0;
	 
    case (state_reg)
        a: begin
            if (Inicie) // si le dan permiso, entonces inicia el proce
                state_next = b; 
                 
            else 
                state_next = a;
                
            end
        b: begin
            if (Fin1) 
                state_next = c; 
            else if (Sent_A1) begin
                state_next = b; Direccion = 8'h21; SD = 1'b1;end// direccion registro 8'h21 segundos de reloj
            else if (Sent_D1) begin
                state_next = b; AddReg = 4'd0;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
            else begin
                state_next = b;end
            end
        c: begin
            if (Fin1) 
                state_next = d; 
            else if (Sent_A1) begin
                state_next = c; Direccion = 8'h22;end// direccion registro 8'h22 minutos de reloj
            else if (Sent_D1) begin
                state_next = c; AddReg = 4'd1; SD=1'b1;end	// se indica direccion de registro donde se debe buscar el dato			
				else 
					 state_next = c;
            end
            
        d: begin
            if (Fin1) 
                state_next = e; 
            else if (Sent_A1) begin
                state_next = d; Direccion = 8'h23; SD = 1'b1;end// direccion registro 8'h23 hora de reloj
            else if (Sent_D1) begin
                state_next = d; SD=1'b1; AddReg = 4'd2;end// se indica direccion de registro donde se debe buscar el dato
				else 
					 state_next = d;
            end   
		  e: begin
            if (Fin1) begin  
                state_next = a; Ready = 1'b1; end // se envia señal indicando que el proceso de inicializacion ha concluido
            else if (Sent_A1) begin
                state_next = e; Direccion = 8'hF1; SD=1'b1;end// se envia comando para hacer transferencia de RAM a area reservada
            else if (Sent_D1) begin
                state_next = e; Cmd = 1'b1; SD = 1'b1;end// se habilita el envio de comando
				else
					 state_next = e;
            end	
        default : state_next = a;
    endcase
end// se asignan señales de control y de datos
assign ReadyR =Ready;
assign DireccionR = Direccion;
assign AddRegR = AddReg;
assign SDR = SD;
assign CMD = Cmd;
endmodule
