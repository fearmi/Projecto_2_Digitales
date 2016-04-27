`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:21 04/12/2016 
// Design Name: 
// Module Name:    TOP_RTC_ 
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
module TOP_RTC_( // modulo top del proyecto
		
    input wire B1, //boton
    input wire B2, //boton
    input wire B3, //boton
    input wire B4, //boton
    input wire B5, // boton
    input wire f0, //interruptor
    input wire f1, //interruptor
    input wire f2, //interruptor
    input wire RESET, //reset
    input wire CLOCK, //clock 100Mhz
	 input wire IRQ,
    input Formato, // am_pm
    inout tri[7:0] DATO_RTC, //rtc
    output AD_TOP, //rtc
    output RD_TOP, //rtc
    output CS_TOP, //rtc
    output WR_TOP, //rtc
    output [2:0] RGB, //vga
    output  VSYNC, //vga
    output  HSYNC,//vga
	 output clock
    );
//botones, rebote tratado
wire Up,Down,Left,Rigth,Ok,fh,ff,ft;
//dato leido del rtc
wire [7:0] datoleer;
//indicadores de inicio en diferentes maquinas
wire Ini,Ini_Ini, Ini_Read,Ini_PR,Ini_PF, Ini_PT;
// señales de control 
wire C_WE,C_VGA,C_Sel_Signal,R,S;

wire [1:0] C_Sel_Progra;

wire S_TC1,H_TC1,M_TC1,D_F1,M_F1,A_F1;
// señales de control, ya se de inicializacion, lectura, progra reloj, progra fecha o progra timer
wire ADR,RDR,WRR,CSR,SDR,CMD;

wire ADF,RDF,WRF,CSF,SDF,CMDF;

wire ADT,RDT,WRT,CST,SDT,CMDT;

wire ADI,RDI,WRI,CSI,SDI,CMDI;

wire ADO,RDO,WRO,CSO,SDO,CMDO;

wire AD,RD,WR,CS,SA,A_D,LeeD;
//inidicadores de listo
wire ReadyR,ReadyF,ReadyT,Ready;
//wires para direcciones de registros, mux o demux
wire [3:0] AddRegR,AddRegF,AddRegT,Code,Reg,RegO,Addr1,Add;
//direcciones en cada progra o lectura
wire [7:0] DireccionR,DireccionF, DireccionT, Direc_Dato1, Direccion1;
//direcciones de decodificadores o mux
wire [7:0] Dato_Reg,DO,Seg,Min,Hr,Ds,Ms,As;
//direcciones extra
wire [7:0] data_out,DIRF,Dato_out;
wire [3:0] Code_Dmux;
wire [7:0] Dato_vga;
wire [7:0] wr_data;
wire [7:0]Comnd_sal;
//registros del demux que van al rtc
wire [7:0] R0,R1,R2,R3,R4,R5,R6,R7,R8;
//señales de reloj con frecuencia variable
wire Clock_o,Clock_o2;


// Instantiate the module
Divisor1 divi1 ( // divisor de frecuencia de 100MHz a 10KHz
    .Clock_i(CLOCK), 
    .reset_i(RESET), //reset
    .Clock_o(Clock_o)
    );

// Instantiate the module
Divisor2 divi2 ( // divisor de frecuencia de 100MHz a 2Hz
    .Clock_i(CLOCK), 
    .reset_i(RESET), //reset
    .Clock_o2(Clock_o2)
    );
// Instantiate the module
Control_Rebote Antirebote ( //modulo de control de antirebote
    .Clock(Clock_o),  // este bloque tiene una señal de clock de 10khz
    .Reset(RESET), 
    .B_S(B1), //boton
    .B_B(B2), //boton
    .B_I(B3), //boton
    .B_D(B4), //boton
    .B_OK(B5), //boton
	 .I1(f0), //interruptor
    .I2(f1), //interruptor
    .I3(f2),//interruptor
    .Up(Up), //subir
    .Down(Down), //bajar
    .Left(Left), //desplazar a la izquierda
    .Rigth(Rigth),//despalazar a la derecha
	 .Ok(Ok),//ok
	 .F0(fh), //interruptor programar hora
    .F1(ff), //interruptor programar fecha
    .F2(ft) //interruptor programar timer
    );

// Instantiate the module
Control_General_RTC ControlGeneralRTC (
    .Reset(RESET),//reset 
    .Clock(CLOCK), 
    .L_Ini(Ready), //señal que indica final de un ciclo de programacion (entrada a control general)
    .L_Re(ReadyR),//señal que indica final de un ciclo de programacion(entrada a control general)
    .L_Fe(ReadyF), //señal que indica final de un ciclo de programacion(entrada a control general)
    .L_Ti(ReadyT), //señal que indica final de un ciclo de programacion(entrada a control general)
    .Listo(Listo1), //señal que indica final de un ciclo de programacion(entrada a control general)
    .C_WE(C_WE), //señal de control 
    .C_VGA(C_VGA), //señal de control
    .C_Sel_Progra(C_Sel_Progra), //señal de control
    .C_Sel_Signal(C_Sel_Signal), //señal de control
	 .Ini(Ini), //señal de control
    .Ini_Ini(Ini_Ini), //señal de control
    .Ini_Read(Ini_Read), //señal de control
    .Ini_PR(Ini_PR), //señal de control
    .Ini_PF(Ini_PF), //señal de control
    .Ini_PT(Ini_PT), //señal de control
    .F0(fh), //entrada interruptor
    .F1(ff), //entrada de interruptor
    .F2(ft) // entrada de interruptor
    );

// Instantiate the module
Inicia Ini_del_RTC (// modulo de programacion de inicializacion
    .Clock(CLOCK), 
    .Reset(RESET), //reset
    .Inicie(Ini_Ini), 
    .Ready(Ready), 
    .Reg(Reg), 
    .Direc_Dato1(Direc_Dato1), 
    .ADI(ADI), 
    .RDI(RDI), 
    .WRI(WRI), 
    .CSI(CSI), 
    .SDI(SDI),
	 .CMDI(CMDI)
    );

// Instantiate the module
Leer_RTC Leer (// modulo de lectura de parametros de reloj,fecha y timer del rtc v3023
    .Clock(CLOCK), 
    .Reset(RESET), //reset
    .Inicie(Ini_Read), 
    .Direccion1(Direccion1), 
    .Code(Code), 
    .AD(AD), 
    .RD(RD), 
    .WR(WR), 
    .CS(CS), 
	 .SA(SA),
	 .LeeD(LeeD)
    );
// Instantiate the module
Nueva_Progra Programar_Clock (// modulo de programacion de reloj
    .Clock(CLOCK), 
    .Reset(RESET), //reset
    .Inicie(Ini_PR),
    .ReadyR(ReadyR),
    .AddRegR(AddRegR), 
    .DireccionR(DireccionR), 
    .ADR(ADR), 
    .RDR(RDR), 
    .WRR(WRR), 
    .CSR(CSR), 
    .SDR(SDR),
	 .CMD(CMD)
    );

// Instantiate the module
Nueva_Progra1 Programar_Fecha (// modulo de programacion de fecha
    .Clock(CLOCK), 
    .Reset(RESET), //reset
    .Inicie(Ini_PF),
    .ReadyF(ReadyF),	 
    .DireccionF(DireccionF), 
    .AddRegF(AddRegF), 
    .ADF(ADF), 
    .RDF(RDF), 
    .WRF(WRF), 
    .CSF(CSF), 
    .SDF(SDF),
	 .CMDF(CMDF)
    );
	// Instantiate the module
Nueva_Progra2 Programar_Crono ( // modulo de programacion de timer
    .Clock(CLOCK), 
    .Reset(RESET), //reset
    .Inicie(Ini_PT),
    .ReadyT(ReadyT),	 
    .AddRegT(AddRegT), 
    .DireccionT(DireccionT), 
    .ADT(ADT), 
    .RDT(RDT), 
    .WRT(WRT), 
    .CST(CST), 
    .SDT(SDT),
	 .CMDT(CMDT)
    );
//multilpexores para seleccionar entre señales de control de cada una de las progras (reloj,fecha,timer e inicializacion)
// Instantiate the module
Mux_AD MUxAD (
    .AD_I(ADI), 
    .AD_R(ADR), 
    .AD_F(ADF), 
    .AD_T(ADT), 
    .Select(C_Sel_Progra), 
    .ADO(ADO)
    );
Mux_AD MUxCMD (
    .AD_I(CMDI), 
    .AD_R(CMD), 
    .AD_F(CMDF), 
    .AD_T(CMDT), 
    .Select(C_Sel_Progra), 
    .ADO(CMDO)
    );
// Instantiate the module
Mux_CS Chip_Select (
    .CS_I(CSI), 
    .CS_R(CSR), 
    .CS_F(CSF), 
    .CS_T(CST), 
    .Select(C_Sel_Progra), 
    .CSO(CSO)
    );
// Instantiate the module
Mux_WR Write (
    .WR_I(WRI), 
    .WR_R(WRR), 
    .WR_F(WRF), 
    .WR_T(WRT), 
    .Select(C_Sel_Progra), 
    .WRO(WRO)
    );
// Instantiate the module
Mux_Direcc_Dato Mux_Direccion (
    .D_I(Direc_Dato1), //inicializacion
    .D_R(DireccionR), //progra de hora
    .D_F(DireccionF), //progra de fecha
    .D_T(DireccionT), //progra de timer
    .Select(C_Sel_Progra), //señal de seleccion
    .DO(DO) //direccion salida
    );
// Instantiate the module
Mux_RegAdd RegAdd (
    .Reg_I(Reg), //inicializacion
    .Reg_R(AddRegR), //programar reloj
    .Reg_F(AddRegF), //programar fecha
    .Reg_T(AddRegT), //programar timer
    .Select(C_Sel_Progra), // señal de seleccion
    .RegO(RegO) // señal de direccionamiento final, va a otro mux para seleccionar entre progra de rtc y progra con boton
    );
// Instantiate the module
Mux_SD Sent_Data (
    .SD_I(SDI), 
    .SD_R(SDR), 
    .SD_F(SDF), 
    .SD_T(SDT), 
    .Select(C_Sel_Progra), 
    .SDO(SDO)
    );
Mux_SD Read_Data (
    .SD_I(RDI), 
    .SD_R(RDR), 
    .SD_F(RDF), 
    .SD_T(RDT), 
    .Select(C_Sel_Progra), 
    .SDO(RDO)
    );
// fin
// Instantiate the module
Mux_Sig_Control Signal_Control (
    .ADR(AD), //señal de lectura AD
    .ADW(ADO), //señal de escritura AD
    .CSR(CS), //señal de lectura Chip Select
    .CSW(CSO), //señal de escritura Chip Select
    .RDR(RD), //señal de RD de lectura
    .RDW(RDO), //señal de RD de escritura
    .WRR(WR), //señal de WR de lectura
    .WRW(WRO), //señal de WR de escritura
    .DIR(Direccion1), //direccion de inicializacion
    .DIW(DO), // direcciona
    .ADf(AD_TOP), //señales de control final
    .CSf(CS_TOP), //señales de control final
    .RDf(RD_TOP), //señales de control final
    .WRf(WR_TOP), //señales de control final
    .DIRF(DIRF), // direccion de salida a bus de datos
    .Sel(~C_Sel_Signal) // señal de seleccion
    );
//multiplexores para señales de escribir_dato, direccion/dato y leer dato para modulo de manejo de bus de datos
Mux_Write_Enable escribir_dato (
    .P(SDO), 
    .P1(SA), 
    .Select(C_Sel_Signal), 
    .WE(S) //bus de datos
    );
Mux_Write_Enable seleccionar_dato_direccion (
    .P(ADO), 
    .P1(AD), 
    .Select(C_Sel_Signal), 
    .WE(A_D) //bus de datos
    );
Mux_Write_Enable leer_dato (
    .P(~RDO), 
    .P1(LeeD), 
    .Select(C_Sel_Signal), 
    .WE(R) //bus de datos
    );
// fin
// Instantiate the module
Comandos_RTC comandos ( // deco de comandos
    .Comnd_in(C_Sel_Progra), // selector de comando
    .Comnd_sal(Comnd_sal) //salida de comando
    );

Mux_Code Data_Write ( //si es uno pasa el boton, en otro caso el dato leido
    .Dato_RTC(data_out), //dato que viene de la lectura en el rtc
    .Dato_Boton(Comnd_sal), // dato que viene de la programación con botones
    .Select(~CMDO), // selector de dato
    .Dato_vga(wr_data) // dato de salida
    );
// Instantiate the module
Bus_Datos Manejo_Bus_Datos (
    .clk(CLOCK), //clcok de 100 mhz
    .leerdato(R), //señal para habilitar lectura de dato 
    .escribirdato(S), //señal para habilitar dato 
    .AD(A_D), //señal para escoger entre direccion y dato
    .direccion(DIRF), // direccion
    .datoescribir(wr_data), //dato a escribir
    .datoleer(datoleer), // dato que se lee
    .salient(DATO_RTC) //dato que sale
    );

// Instantiate the module
Control_Botones ControlBotones (
    .Reset(RESET), //reset
    .Ini(Ini), // entrada que habilita el proceso de maquina de estados
    .F0(fh), //programar reloj
    .F1(ff), //programar fecha
    .F2(ft),//programar timer
    .S(Left), //desplazar a la izquierda
    .B(Rigth), // desplazar a la derecha
    .S_TC1(S_TC1), //out
    .M_TC1(M_TC1), //out
    .H_TC1(H_TC1), //out
    .Clock(Clock_o), // clock de khz
    .OK(Ok), // boton de ok
    .D_F1(D_F1), //out
    .M_F1(M_F1), //out
    .A_F1(A_F1), //out
    .Listo1(Listo1), //out 
    .Addr1(Addr1), //para direccionar el banco de registros
    .WE1(WE1) //out
    );


Contadores_Decos Contadores ( //unida de contadores y decodificadores
    .Clock_in(Clock_o2), // señal de reloj de 2Hz
    .Reset_in(RESET), //reset
    .Format(Formato), // formato de 12 o 24 horas
    .Up(Up), // aumentar 
    .Dw(Down), // disminuir
    .STC(S_TC1), //habilita contador de segundos
    .MTC(M_TC1), //habilita contador de minutos
    .HTC(H_TC1), //habilita contador de hora
    .DF(D_F1), //habilita contador de dia
    .MF(M_F1), //habilita contador de mes
    .AF(A_F1), //habilita contador de año
    .Seg(Seg), // salida de dato
	 .Min(Min),// salida de dato
    .Hr(Hr), // salida de dato
    .Ds(Ds), // salida de dato
    .Ms(Ms),// salida de dato 
    .As(As)// salida de dato
    );
// Instantiate the module
Mux_AddReg Direccion_BancoReg ( //esto lo uso cuando programo
    .Add1(Addr1), //botones 
    .Add2(RegO),  //progra
    .Select(C_WE), // señal de seleccion
    .Add(Add) // señal de direccionamiento de banco de registros
    );


// Instantiate the module
Mux_Banco_Reg Mux_BancoReg (
    .Seg_RT(Seg), // segundos, salida de contadores y decodificadores, entrada a mux
    .Min_RT(Min), // minutos, salida de contadores y decodificadores, entrada a mux
    .Hor_RT(Hr), // hora, salida de contadores y decodificadores, entrada a mux
    .Dia(Ds), // dia, salida de contadores y decodificadores, entrada a mux
    .Mes(Ms), // mes, salida de contadores y decodificadores, entrada a mux
    .Ao(As), // año, salida de contadores y decodificadores, entrada a mux
    .Dato_Reg(Dato_Reg), // dato salida que se quiere almacenar en el banco de registros
    .Selector(Addr1) //señal de direccion que viene del control de botones
    );

// Instantiate the module
regfile Banco_Registros ( // banco de resgistros
    .clock(CLOCK), 
    .address(Add), //señal para direccionar entre registros
    .en_write(C_WE), // señal para habilitar escritura o lectura
    .data_in(Dato_Reg), // dato de entrada, proviene de la programación con botones
    .data_out(data_out) // dato de salida va como "dato a enviar" al manejo de bus de datos
    );

// Instantiate the module
Mux_Code_Reg Code_Demux ( //si es 0 pasa Addr1 y si es cero entonces Code
    .Code1(Code), // direccion que proviene del control de botones
    .Code2(Addr1), // direccion que proviene del control de lectura
    .Select(C_VGA), //señal de control que viene del control general
    .Code_Dmux(Code_Dmux) // señal de salida final a demux
    );

// Instantiate the module
Mux_Code Dato_VGA ( //si es uno pasa el boton, en otro caso el dato leido
    .Dato_RTC(datoleer), //dato que viene de la lectura en el rtc
    .Dato_Boton(Dato_Reg), // dato que viene de la programación con botones
    .Select(C_VGA), // selector de dato
    .Dato_vga(Dato_vga) // dato de salida
    );

// Instantiate the module
DeMux DeMUX_VGA ( // demultiplexor para mostrar dato en vga
    .clk(CLOCK), //CLOCK de 100Mhz
    .reset(RESET), //reset
    .dato(Dato_vga), //dato que ingresa al dmux para ser presentado en pantalla
    .selector(Code_Dmux), //selector de dato
    .R0(R0), // salida, segundos reloj
    .R1(R1),  // salida, minuitos reloj
    .R2(R2),  // salida, hora reloj
    .R3(R3),  // salida, dia fecha
    .R4(R4),  // salida, mes fecha
    .R5(R5),  // salida, año fecha
    .R6(R6),  // salida, segundos timer
    .R7(R7),  // salida, minutos timer
    .R8(R8) // salida, hora timer
    );

// Instantiate the module
VGA control_vga ( // modulo top generador de interfaz de vga
    .reloj(CLOCK), //CLOCK de 100Mhz
    .reset(RESET),  //reset
    .a(IRQ), 
	 .control(Addr1), // señal de direccionamiento de cursos cuando se programa con botones
    .r0(R0), // entrada, segundos reloj
    .r1(R1), // entrada, minuitos reloj
    .r2(R2), // entrada, hora reloj
    .r3(R3), // entrada, dia fecha
    .r4(R4), // entrada, mes fecha
    .r5(R5), // emtrada, año fecha
    .r6(R6), // entrada, segundos timer
    .r7(R7), // entrada, minutos timer
    .r8(R8), // entrada, hora timer
    .rgb(RGB), // rgb
    .hsync(HSYNC),//posicion horizontal
    .vsync(VSYNC) // posicion vertical
    );
assign clock = CLOCK;	 // esta señal se asigna para conectar a analizador lógico
endmodule
