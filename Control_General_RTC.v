`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:25:44 04/12/2016 
// Design Name: 
// Module Name:    Control_General_RTC 
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
module Control_General_RTC(
    input Reset, // RESET global
    input Clock, // Se�al de Reloj
    input L_Ini, // S�al que indica que program� Inicializacion
    input L_Re, // Se�al que indica que se program� Reloj
    input L_Fe, // Se�al que indica que se program� Fecha
    input L_Ti, // Se�al que indica que se program� Timer
	 input Listo, // Se�al que indica que la progra con control de botones termina
    output C_WE,C_VGA, // se�al �ra habilitar WE de banco de registros
    output [1:0] C_Sel_Progra, // Se�al para hanilitar se�al de salida
    output C_Sel_Signal, // se�al para habilitar Se�ales de progra o lectura
	 output Ini,
    output Ini_Ini, // Se�al para iniciar inicializaci�n
    output Ini_Read, // Se�al para Iniciar Lectura
    output Ini_PR, // Se�al para iniciar progra de reloj
    output Ini_PF, // Se�al para iniciar progra de fecha
    output Ini_PT, // Se�al para iniciar progra de timer
    input F0, // interruptor, programar reloj
    input F1, // Interruptor, programar timer
    input F2 // Interruptor programar fecha
    );
	 
localparam [3:0] a = 4'd0, //parametros locales de asigancion de estados
                      b = 4'd1,
                      c = 4'd2,
                      d = 4'd3,
                      e = 4'd4,
                      f = 4'd5,
                      g = 4'd6,
							 h = 4'd7,
							 i = 4'd8,
							 j = 4'd9;
							 
reg [3:0] state_reg, state_next;

reg WE,VGA, C_SS,Ini_I,Ini_R,Ini_Pr,Ini_Pf,Ini_Pt,Ini1; // se definen variables 
reg [1:0] C_SP;

always @(posedge Clock) // en cada flanco positivo

    if (Reset)
        state_reg <= a; // si reset en alto, permanezca en a
    else 
        state_reg <= state_next; // en caso contrario asigne estado actual a estado siguiente
//l�gica de estado siguiente
always @*
begin // se inicializa el valor de cada una de las variables
    state_next=state_reg;
    WE = 1'b0; // permite habilitar direcciones en registros de datos 
	 Ini1 = 1'b0; // habilita programacion inicial
    Ini_I = 1'b0; // habilita proceso de inicializacion de rtc
    Ini_R = 1'b0; // habilita lectura
    Ini_Pr = 1'b0; // habilita programacion de reloj
    Ini_Pf = 1'b0; // habilita programacion de fecha
    Ini_Pt = 1'b0; // habilita programacion de timer
	 C_SS = 1'b0; // indica qu� datos, direcciones y se�ales pasan al rtc, lectura o escritura
	 C_SP = 2'b00; // indica qu� se�ales de control pasan al mux de se�ales de control, se�ales de programaci�n
	 VGA = 1'b0; // indica qu� dato se pasa al demux de vga
    
    case (state_reg)
        a: begin
            if (~Reset) // si reset negado, pase a b
                state_next = b; 
                 
            else 
                state_next = a; // quedese en a
                
            end
        b: begin
            if (Listo) //cuando la programaci�n con botones indique que termin�, pase a c
                state_next = c;
				else begin
					 state_next = b; Ini1 = 1'b1; WE = 1'b1; // sino quedese en b y permita que se programe con botones
				end
            end
        c: begin
            if (L_Ini) // cuando la inicializaci�n haya terminado, pase a d
                state_next = d;
            else begin // sino quedese en c y permitale programar el rtc
                state_next = c;Ini_I = 1'b1; C_SS = 1'b1; WE = 1'b0; end 
            end
            
        d: begin // este es el estado en el que se lee, permanece aqu� a menos que se decida programar algo
            if (Reset) state_next = a; // regrese al estado base
            else if (F0) state_next = e; // pase a e si se quiere programar reloj
				else if (F1) state_next = f; // fecha
				else if (F2) state_next = g; // timer
            else begin // en caso contrario habilite la maquina de lectura y los registros
                state_next = d;Ini_R = 1'b1; C_SS = 1'b0; C_SP=2'b00; WE = 1'b1; VGA = 1'b1; end
            end    
        e: begin
            if (Listo) //aqui programo con botones
                state_next = h;	 
            else begin
                state_next = e; WE = 1'b1; VGA = 1'b0; end// se programa reloj
            end
        f: begin
            if (Listo) //aqui programo con botones
                state_next = i;
            else begin
                state_next = f; WE = 1'b1; VGA = 1'b0;end// se programa fecha
            end
        g: begin
            if (Listo) //aqui programo con botones
                state_next = j;
            else begin
                state_next = g; WE = 1'b1; VGA = 1'b0;end// se programa timer
            end
            
        h: begin
            if (L_Re) // si se termina de programar el reloj entonces pase a leer
                state_next = d;
            else begin // en caso contrario, permitale seguir enviando datos de programacion
                state_next = h; Ini_Pr= 1'b1; WE = 1'b0; C_SP = 2'b01;C_SS=1'b1;end
            end  
        i: begin
            if (L_Fe) // si se termina de programar la fecha entonces pase a leer
                state_next = d;	 
            else begin// en caso contrario, permitale seguir enviando datos de programacion
                state_next = i; Ini_Pf= 1'b1; WE = 1'b0; C_SP = 2'b10;C_SS=1'b1; end
            end
        j: begin
            if (L_Ti)// si se termina de programar el timer entonces pase a leer
                state_next = d;
            else begin// en caso contrario, permitale seguir enviando datos de programacion
                state_next = j;Ini_Pt= 1'b1; WE = 1'b0; C_SP = 2'b11;C_SS=1'b1; end
            end
   
		  default : state_next = a;
    endcase
end // se hace la asignaci�n final de las salidas de control a otras maquinas
assign Ini=Ini1,C_VGA = VGA,C_WE = WE,Ini_Ini= Ini_I,Ini_Read=Ini_R,Ini_PR=Ini_Pr,Ini_PF=Ini_Pf,Ini_PT=Ini_Pt,C_Sel_Signal=C_SS ,C_Sel_Progra=C_SP;
endmodule
