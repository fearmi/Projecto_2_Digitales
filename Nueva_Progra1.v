`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:19:57 04/19/2016 
// Design Name: 
// Module Name:    Nueva_Progra1 
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
module Nueva_Progra1(// señales de entrada y salida
	 input Clock,
    input Reset,
    input Inicie,// señal que permite iniciar el proceso de inicializacion
	 output ReadyF,// Señal que indica que el proceso ha terminado
	 output [3:0]AddRegF,// señal que direcciona en registro de datos a programar
    output [7:0]DireccionF,// direccion
	 output ADF,RDF,WRF,CSF,SDF,CMDF// señales de control de rtc (A/D,CS,RD,WR).
    );// SD permite indicar cuándo enviar el dato y CMD indica cuál comando (F0,F1,F2)
localparam [2:0] a = 3'd0,// Parametros
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
Escribir_Escribir Write_Write (// maquina de estados de programacion, se encarga de enviar señales de control
    .Reset(Reset), // su funcion es generar los tiempos necesarios parA el correcto funcionamiento del rtc
    .ciclo(Inicie),  // los tiempos se basan en el diagrama de tiempos de INTEL de la hoja de datos del V3023
    .Clock_in(Clock), 
    .A_D1(ADF), 
    .CS1(CSF), 
    .WR1(WRF), 
    .RD1(RDF), 
    .Sent_A1(Sent_A1), // indica cuándo enviar direccion
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
            if (Inicie)  // si le dan permiso, entonces inicia el proce
                state_next = b; 
                 
            else 
                state_next = a;
                
            end
        b: begin
            if (Fin1) 
                state_next = c; 
            else if (Sent_A1) begin
                state_next = b; Direccion = 8'h24; SD = 1'b1;end// direccion registro 8'h24 día de fecha
            else if (Sent_D1) begin
                state_next = b; AddReg = 4'd3;SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato
            else begin
                state_next = b;end
            end
        c: begin
            if (Fin1) 
                state_next = d; 
            else if (Sent_A1) begin
                state_next = c; Direccion = 8'h25;end// direccion registro 8'h25 mes de fecha
            else if (Sent_D1) begin
                state_next = c; AddReg = 4'd4; SD=1'b1;end// se indica direccion de registro donde se debe buscar el dato				
				else 
					 state_next = c;
            end
            
        d: begin
            if (Fin1) 
                state_next = e; 
            else if (Sent_A1) begin
                state_next = d; Direccion = 8'h26; SD = 1'b1;end// direccion registro 8'h26 año de fecha
            else if (Sent_D1) begin
                state_next = d; SD=1'b1; AddReg = 4'd5;end// se indica direccion de registro donde se debe buscar el dato
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
assign ReadyF =Ready;
assign DireccionF = Direccion;
assign AddRegF = AddReg;
assign SDF = SD;
assign CMDF = Cmd;
endmodule
