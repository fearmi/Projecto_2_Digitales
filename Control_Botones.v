`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:06 03/31/2016 
// Design Name: 
// Module Name:    Control_Botones 
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
module Control_Botones(
	 input Clock, // señal de clock de entrada
    input Reset,
	 input Ini, //Señal de entrada para realizar la primera programacion del RTC del proceso de inicializacion
    input F0, // programar reloj
    input F1, // programar fecha
    input F2, // programar timer
	 input S,B, // señales de entrada de botones para subir y bajar
	 input OK, // me ayuda a saltar de estado
    output S_TC1, //habilita contador BCD de segundos
    output M_TC1, // habilita contador BCD de minutos
    output H_TC1, // habilita contador BCD de hora
    output D_F1, //habilita contador BCD de dias
    output M_F1, // habilita contador BCD de meses 
    output A_F1, // habilita contador BCD de año
	 output Listo1, // indica cuando el proceso ha finalizado
	 output [3:0] Addr1, // salida para direccionar banco de registros
	 output WE1 // permite escribir en el banco de registros
    );
	 
localparam [4:0] a = 5'd0,
                      b = 5'd1,
                      c = 5'd2,
                      d = 5'd3,
                      e = 5'd4,
                      f = 5'd5,
                      g = 5'd6,
							 h = 5'd7,
							 i = 5'd8,
							 j = 5'd9,
							 k = 5'd10,
							 l = 5'd11,
							 m = 5'd12,
							 n = 5'd13,
							 o = 5'd14,
							 p = 5'd15,
							 q = 5'd16,
							 r = 5'd17,
							 s = 5'd18,
							 t = 5'd19;
                      
reg [4:0] state_reg, state_next;
reg S_TC,M_TC,H_TC,D_F,M_F,A_F,Listo,WE;
reg [3:0] Addr;
always @(posedge Clock) 

    if (Reset)
        state_reg <= a;
    else 
        state_reg <= state_next;
//lógica de estado siguiente
always @*
begin
    state_next=state_reg;
    S_TC = 1'b0;
    M_TC = 1'b0;
    H_TC = 1'b0;
    D_F = 1'b0;
    M_F = 1'b0;
    A_F = 1'b0;
	 Listo = 1'b0;
	 WE = 1'b0;
	 Addr = 4'h9;
    
    case (state_reg)
        a: begin
            if (~Reset) 
                state_next = b; 
                 
            else 
                state_next = a; 
                
            end
        b: begin
            if (F0) // programar hora
                state_next = c;
				else if (F1) // programar fecha
					 state_next = f;
            else if (Ini) //generar programación inicial del rtc
                state_next = i;
				else if (F2)//programar cronometro
					 state_next = r;
				else 
					state_next = b;
            end
        c: begin
            if (OK) begin
                state_next = a; Listo = 1'b1; end
                
            else if (S) state_next = d;
            else begin 
                state_next = c;S_TC = 1'b1; WE = 1'b1; Addr = 4'd0; end 
            end
            
        d: begin
            if (OK) begin
                state_next = a; Listo = 1'b1 ; end
           // else if (S) state_next = e;
				else if (B) state_next = e;
                
            else begin
                state_next = d;M_TC = 1'b1; WE = 1'b1; Addr = 4'd1;end
               
            end    
        e: begin
            if (OK) begin
                state_next = a; Listo = 1'b1; end
				else if (S) state_next = d;	 
            else begin
                state_next = e;  H_TC = 1'b1; WE = 1'b1; Addr = 4'd2; end
            end
        r: begin
            if (OK) begin
                state_next = a; Listo = 1'b1; end
                
            else if (S) state_next = s;
            else begin 
                state_next = r;S_TC = 1'b1; WE = 1'b1; Addr = 4'd6; end 
            end
            
        s: begin
            if (OK) begin
                state_next = a; Listo = 1'b1;end
           // else if (S) state_next = t;
				else if (B) state_next = t;
                
            else begin
                state_next = s;M_TC = 1'b1; WE = 1'b1; Addr = 4'd7;end
               
            end    
        t: begin
            if (OK) begin
                state_next = a; Listo = 1'b1; end
				else if (S) state_next = s;	 
            else begin
                state_next = t;  H_TC = 1'b1; WE = 1'b1; Addr = 4'd8; end
            end
        f: begin
            if (OK) begin
                state_next = a; Listo = 1'b1;end
				else if (S) state_next = g;
            else begin
                state_next = f;D_F = 1'b1; WE = 1'b1; Addr = 4'd3;end
            end
        g:begin
            if (OK) begin
                state_next = a; Listo = 1'b1; end
            //else if (S) state_next = h;
				else if (B) state_next = h;
            else begin
                state_next = g ; M_F = 1'b1; WE = 1'b1; Addr = 4'd4;end
            end
        h: begin
            if (OK) begin
                state_next = a; Listo = 1'b1; end
				else if (S) state_next = g;
            else begin
                state_next = h;  A_F = 1'b1; WE = 1'b1; Addr = 4'd5;end 
			  end 
		  i: begin  //inician los estados de inicialización   
            if (OK) state_next = j; // aqui iba S
            else begin 
                state_next = i;S_TC = 1'b1; WE = 1'b1; Addr = 4'd0; end //aca se programan segundos
            end
            
        j: begin //minutos de la inicializacion
            if (S) state_next = k;
				else if (B) state_next = i;     
            else begin
                state_next = j;M_TC = 1'b1; WE = 1'b1; Addr = 4'd1;end //aca se programan minutos
            end    
        k: begin
            if (OK) //horas de la inicializacion
                state_next = l;
				else if (B) state_next = j;	 
            else begin
                state_next = k;  H_TC = 1'b1; WE = 1'b1; Addr = 4'd2; end
            end
		  l: begin    //dias de la inicializacion
            if (S) state_next = m;
            else begin 
                state_next = l;D_F = 1'b1; WE = 1'b1; Addr = 4'd3; end 
            end
            
        m: begin //meses de la inicializacion
            if (OK) state_next = n;
				else if (B) state_next = l;     
            else begin
                state_next = m;M_F = 1'b1; WE = 1'b1; Addr = 4'd4; end
            end    
        n: begin
            if (S) //años de la inicializacion
                state_next = o;
				else if (B) state_next = m;	 
            else begin
                state_next = n;  A_F = 1'b1;  WE = 1'b1; Addr = 4'd5; end
            end
		  o: begin    // segundos del timer de inicializacion
            if (S) state_next = p;
            else begin 
                state_next = o;S_TC = 1'b1; WE = 1'b1; Addr = 4'd6; end 
            end
            
        p: begin // minutos de la del timer inicializacion
            if (S) state_next = q;
				else if (B) state_next = o;     
            else begin
                state_next = p;M_TC = 1'b1; WE = 1'b1; Addr = 4'd7;end
            end    
        q: begin // horas del timer de inicializacion
            if (OK) begin 
                state_next = a; Listo = 1'b1; end
				else if (B) state_next = p;	 
            else begin
                state_next = q;  H_TC = 1'b1; WE = 1'b1; Addr = 4'd8; end
            end
			
		  default : state_next = a;
    endcase
end
assign S_TC1=S_TC,M_TC1=M_TC,H_TC1=H_TC,D_F1=D_F,M_F1=M_F,A_F1=A_F,Listo1=Listo, Addr1 = Addr, WE1 = WE;
endmodule
