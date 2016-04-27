`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:36 04/04/2016 
// Design Name: 
// Module Name:    Leer_RTC 
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
module Leer_RTC(// señales de entrada y salida
    input Clock,
    input Reset,
    input Inicie,
    output [7:0]Direccion1,
	 output [3:0] Code, // señal para direccionar demux de vga
	 output AD,RD,WR,CS,SA, LeeD // señales de control
    );


	
localparam [3:0] a = 4'd0, // parametros locales
                      b = 4'd1,
                      c = 4'd2,
                      d = 4'd3,
                      e = 4'd4,
                      f = 4'd5,
                      g = 4'd6,
                      h = 4'd7,
                      i = 4'd8,
                      j = 4'd9,
                      k = 4'd10;
							 
reg [3:0] state_reg, state_next;
reg [3:0] Op_code;
wire Fin1,Sent_A1,Sent_D1;
reg S;
reg Lee;
reg [7:0]Direccion;
// Instantiate the module
Write_Read WriteRead ( // maquina de estados de lectura, se encarga de establecer los tiempos entre transferencias
    .Reset(Reset), // ademas de los tiempos entre señales de control, envio de direcciones y datos
    .ciclo(Inicie), 
    .Fin1(Fin1), 
    .Clock_in(Clock), 
    .A_D1(AD), 
    .CS1(CS), 
    .WR1(WR), 
    .RD1(RD), 
    .Sent_A1(Sent_A1), 
    .Sent_D1(Sent_D1)
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
	 Op_code = 4'b1001;
	 Direccion = 8'h00;
    S = 1'b0;
	 Lee = 1'b0;
    case (state_reg)
        a: begin
            if (Inicie) 
                state_next = b; 
                 
            else 
                state_next = a;
                
            end
        b: begin
            if (Fin1) 
                state_next = c; 
            else if (Sent_A1) begin // envia comnado para realizar transferencia de parametros de area reservada a RAM 
                state_next = b; Direccion = 8'hF0;S = 1'b1;end
            else if (Sent_D1) begin
                state_next = b; Direccion = 8'hF0;end 
				else 
					 state_next = b; 
            end
        c: begin
            if (Fin1) 
                state_next = d; 
            else if (Sent_A1) begin
                state_next = c; Direccion = 8'h21; Op_code = 4'b0000;S = 1'b1;end // se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin // envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = c; Op_code=4'b0000; Lee = 1'b1;end // habilita la lectura del dato
				else begin                                           
					 state_next = c; Op_code = 4'b0000; end
            end
            
        d: begin
            if (Fin1) 
                state_next = e; 
            else if (Sent_A1) begin
                state_next = d; Direccion = 8'h22; Op_code = 4'b0001;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = d; Op_code=4'b0001; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = d;Op_code = 4'b0001;end
            end   
		  e: begin
            if (Fin1) 
                state_next = f; 
            else if (Sent_A1) begin
                state_next = e; Direccion = 8'h23; Op_code = 4'b0010;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = e; Op_code=4'b0010; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = e; Op_code = 4'b0010; end
            end	
        f: begin
            if (Fin1) 
                state_next = g; 
            else if (Sent_A1) begin
                state_next = f; Direccion = 8'h24; Op_code = 4'b0011;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = f; Op_code=4'b0011; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = f; Op_code = 4'b0011;end
            end
		 g: begin
            if (Fin1) 
                state_next = h; 
            else if (Sent_A1) begin
                state_next = g; Direccion = 8'h25; Op_code = 4'b0100;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = g; Op_code=4'b0100; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = g; Op_code = 4'b0100; end
            end
		 h: begin
            if (Fin1) 
                state_next = i; 
            else if (Sent_A1) begin
                state_next = h; Direccion = 8'h26; Op_code = 4'b0101;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = h; Op_code=4'b0101; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = h; Op_code = 4'b0101; end
            end
		 i: begin
            if (Fin1) 
                state_next = j; 
            else if (Sent_A1) begin
                state_next = i; Direccion = 8'h41; Op_code = 4'b0110;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = i; Op_code=4'b0110; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = i; Op_code = 4'b0110; end
            end
		 j: begin
            if (Fin1) 
                state_next = k; 
            else if (Sent_A1) begin
                state_next = j; Direccion = 8'h42; Op_code = 4'b0111;S = 1'b1; end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = j; Op_code=4'b0111; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = j; Op_code = 4'b0111;end
            end
		 k: begin
            if (Fin1) 
                state_next = a; 
            else if (Sent_A1) begin
                state_next = k; Direccion = 8'h43; Op_code = 4'b1000;S = 1'b1;end// se envia direccion al registro al que tiene que ir a extraer el dato
            else if (Sent_D1) begin// envia señal de control para habilitar lectura y señal para direccionar dónde se guarda el dato leido
                state_next = k; Op_code=4'b1000; Lee = 1'b1;end// habilita la lectura del dato
				else begin
					 state_next = k; Op_code = 4'b1000;end
            end
        default : state_next = a;
    endcase
end // se asigna señales de control y datos
assign Direccion1 = Direccion;
assign Code = Op_code;
assign SA = S;
assign LeeD = Lee;
endmodule
