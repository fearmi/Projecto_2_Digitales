`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:26:04 04/13/2016 
// Design Name: 
// Module Name:    Generador 
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
module Generador(

    input wire clk,alarma,clock_nexys,
	 input wire [3:0]control,
    input wire [9:0] pix_x, pix_y,
	 input wire [7:0] R_Dia_Fecha,R_Mes_Fecha,R_Ano_Fecha,R_Hora_Hora,R_Hora_Minutos,R_Hora_Segundos,R_Cronometro_Hora,R_Cronometro_Minutos,R_Cronometro_Segundo,
    output reg [2:0] text_rgb
   );

reg[25:0] clk_o;

always @(posedge clk)
begin
if (alarma)
clk_o <= clk_o+1'b1;
else
clk_o<=0;
end

   // signal declaration
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_M_F, char_addr_F,
              char_addr_H, char_addr_C,char_addr_D_F,char_addr_A_F,char_addr_H_H,char_addr_H_M, char_addr_H_S,char_addr_C_H,char_addr_C_M,char_addr_C_S,char_addr_H_Am,char_addr_H_b,char_addr_H_Pm,char_addr_Al  ;
   reg [3:0] row_addr;
   wire [3:0] row_addr_F, row_addr_C, row_addr_H,row_addr_D_F,row_addr_M_F,row_addr_A_F,row_addr_H_H, row_addr_H_M,row_addr_C_H,row_addr_H_S,row_addr_C_M,row_addr_C_S,row_addr_H_Am,row_addr_H_b, row_addr_H_Pm,row_addr_Al;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_F,bit_addr_H,bit_addr_C, bit_addr_D_F,bit_addr_M_F,bit_addr_A_F,bit_addr_H_H, bit_addr_H_M, bit_addr_C_H,bit_addr_H_S,bit_addr_C_M,bit_addr_C_S,bit_addr_H_Am,bit_addr_H_Pm,bit_addr_H_b,bit_addr_Al;
   wire [7:0] font_word;
   wire font_bit, score_on, logo_on, rule_on, Fecha;
   wire [7:0] rule_rom_addr;
	wire Mes_Fecha, Hora,Ano_Fecha,Hora_H,Hora_M;
   // instantiate font ROM
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
   assign Fecha = (pix_y[9:6]==0) &&
                    (0<=pix_x[9:5]) && (pix_x[9:5]<=13);
   assign row_addr_F = pix_y[5:2];
   assign bit_addr_F = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h0: char_addr_F = 7'h44; // D
         4'h1: char_addr_F = 7'h41; // A
         4'h2: char_addr_F = 7'h59; // Y
         4'h3: char_addr_F = 7'h2f; // /
         4'h4: char_addr_F = 7'h4d; // M
         4'h5: char_addr_F = 7'h4f; // O
         4'h6: char_addr_F = 7'h4e; // N
			4'h7: char_addr_F = 7'h54; // T
			4'h8: char_addr_F = 7'h48; // H
         4'h9: char_addr_F = 7'h2f; // /
			4'ha: char_addr_F = 7'h59; // Y
         4'hb: char_addr_F = 7'h45; // E
         4'hc: char_addr_F = 7'h41; // A
			4'hd: char_addr_F = 7'h52; // R
         default: char_addr_F = 7'h00; // 
      endcase
assign Dia_Fecha = (pix_y[9:6]==1) &&
                    (0<=pix_x[9:5]) && (pix_x[9:5]<=1);
   assign row_addr_D_F = pix_y[5:2];
   assign bit_addr_D_F = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h0: char_addr_D_F = {3'b011,R_Dia_Fecha[7:4]}; // Decenas dias
			4'h1: char_addr_D_F = {3'b011,R_Dia_Fecha[3:0]};// Unidades dias
         default: char_addr_D_F = 7'h00; // 
      endcase	
assign Mes_Fecha = (pix_y[9:6]==1) &&
                    (4<=pix_x[9:5]) && (pix_x[9:5]<=5);
   assign row_addr_M_F = pix_y[5:2];
   assign bit_addr_M_F = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h4: char_addr_M_F = {3'b011,R_Mes_Fecha[7:4]}; // Decenas Mes
         4'h5: char_addr_M_F = {3'b011,R_Mes_Fecha[3:0]}; // Unidades Mes
         default: char_addr_M_F = 7'h00; // 
      endcase
assign Ano_Fecha = (pix_y[9:6]==1) &&
                    (7<=pix_x[9:5]) && (pix_x[9:5]<=10);
   assign row_addr_A_F = pix_y[5:2];
   assign bit_addr_A_F = pix_x[4:2];
   always @*
      case(pix_x[8:5])
			4'h7: char_addr_A_F = 7'h32;//2
			4'h8: char_addr_A_F = 7'h30;//0
         4'h9: char_addr_A_F = {3'b011,R_Ano_Fecha[7:4]}; // Decenas Ano
         4'ha: char_addr_A_F = {3'b011,R_Ano_Fecha[3:0]}; // Unidades Ano
         default: char_addr_A_F = 7'h00; // 
      endcase

assign Hora = (pix_y[9:6]==2) &&
                    (0<=pix_x[9:5]) && (pix_x[9:5]<=3);
   assign row_addr_H = pix_y[5:2];
   assign bit_addr_H = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h0: char_addr_H = 7'h48; // H
         4'h1: char_addr_H = 7'h4F; // O
         4'h2: char_addr_H = 7'h55; // R
         4'h3: char_addr_H = 7'h52; // A
         default: char_addr_H = 7'h00; // 
      endcase
assign Hora_H = (pix_y[9:6]==3) &&
                    (0<=pix_x[9:5]) && (pix_x[9:5]<=1);
   assign row_addr_H_H = pix_y[5:2];
   assign bit_addr_H_H = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h0: char_addr_H_H = {3'b0110,R_Hora_Hora[6:4]}; // Decenas horas
         4'h1: char_addr_H_H = {3'b011,R_Hora_Hora[3:0]}; // Unidades horas
         default: char_addr_H_H = 7'h00; // 
      endcase

assign Hora_M = (pix_y[9:6]==3) &&
                    (2<=pix_x[9:5]) && (pix_x[9:5]<=4);
   assign row_addr_H_M = pix_y[5:2];
   assign bit_addr_H_M = pix_x[4:2];
   always @*
      case(pix_x[8:5])
			4'h2: char_addr_H_M = 7'h3a;//:
         4'h3: char_addr_H_M = {3'b011,R_Hora_Minutos[7:4]}; // Decenas horas
         4'h4: char_addr_H_M = {3'b011,R_Hora_Minutos[3:0]}; // Unidades horas
         default: char_addr_H_M = 7'h00; // 
      endcase
				
		
assign Hora_S = (pix_y[9:6]==3) &&
                    (5<=pix_x[9:5]) && (pix_x[9:5]<=7);
   assign row_addr_H_S = pix_y[5:2];
   assign bit_addr_H_S = pix_x[4:2];
   always @*
      case(pix_x[8:5])
			4'h5: char_addr_H_S = 7'h3a;//:
         4'h6: char_addr_H_S = {3'b011,R_Hora_Segundos[7:4]}; // Decenas horas
         4'h7: char_addr_H_S = {3'b011,R_Hora_Segundos[3:0]}; // Unidades horas
         default: char_addr_H_S = 7'h00; // 
      endcase		
assign Hora_AM = (pix_y[9:6]==3) &&
                    (9<=pix_x[9:5]) && (pix_x[9:5]<=10);
   assign row_addr_H_Am = pix_y[5:2];
   assign bit_addr_H_Am = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h9: char_addr_H_Am = 7'h41; // A
         4'ha: char_addr_H_Am = 7'h4d; // M
         default: char_addr_H_Am = 7'h00; // 
      endcase	
assign Hora_PM = (pix_y[9:6]==3) &&
                    (12<=pix_x[9:5]) && (pix_x[9:5]<=13);
   assign row_addr_H_Pm = pix_y[5:2];
   assign bit_addr_H_Pm = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'hc: char_addr_H_Pm = 7'h50; // P
         4'hd: char_addr_H_Pm = 7'h4d; // M
         default: char_addr_H_Pm = 7'h00; // 
      endcase		
assign Hora_b = (pix_y[9:6]==3) &&
                    (11<=pix_x[9:5]) && (pix_x[9:5]<=11);
   assign row_addr_H_b = pix_y[5:2];
   assign bit_addr_H_b = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'hb: char_addr_H_b = 7'h2f; // /
         default: char_addr_H_b = 7'h00; // 
      endcase		
assign CRONOMETRO = (pix_y[9:6]==4) &&
                    (0<=pix_x[9:5]) && (pix_x[9:5]<=4);
   assign row_addr_C = pix_y[5:2];
   assign bit_addr_C = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h0: char_addr_C = 7'h43; // C
         4'h1: char_addr_C = 7'h52; // R
         4'h2: char_addr_C = 7'h4f; // O
         4'h3: char_addr_C = 7'h4e; // N
			4'h4: char_addr_C = 7'h4f; // O
         default: char_addr_C = 7'h00; // 
      endcase	
assign Alarma = (pix_y[9:6]==4) &&
                    (12<=pix_x[9:5]) && (pix_x[9:5]<=15);
   assign row_addr_Al = pix_y[5:2];
   assign bit_addr_Al = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'hc: char_addr_Al = 7'h44; // D
         4'hd: char_addr_Al = 7'h4f; // O
         4'he: char_addr_Al = 7'h4e; // N
         4'hf: char_addr_Al = 7'h45; // E
			
         default: char_addr_Al = 7'h00; // 
      endcase	
assign CRONOMETRO_H = (pix_y[9:6]==5) &&
                    (0<=pix_x[9:5]) && (pix_x[9:5]<=1);
   assign row_addr_C_H = pix_y[5:2];
   assign bit_addr_C_H = pix_x[4:2];
   always @*
      case(pix_x[8:5])
			4'h0: char_addr_C_H = {3'b011,R_Cronometro_Hora[7:4]}; // Decenas horas
         4'h1: char_addr_C_H = {3'b011,R_Cronometro_Hora[3:0]}; // Unidades horas
         default: char_addr_C_H = 7'h00; // 
      endcase	
assign CRONOMETRO_M = (pix_y[9:6]==5) &&
                    (2<=pix_x[9:5]) && (pix_x[9:5]<=4);
   assign row_addr_C_M = pix_y[5:2];
   assign bit_addr_C_M = pix_x[4:2];
   always @*
      case(pix_x[8:5])
			4'h2: char_addr_C_M = 7'h3a;//:
			4'h3: char_addr_C_M = {3'b011,R_Cronometro_Minutos[7:4]}; // Decenas horas
         4'h4: char_addr_C_M = {3'b011,R_Cronometro_Minutos[3:0]}; // Unidades horas
         default: char_addr_C_M = 7'h00; // 
      endcase
assign CRONOMETRO_S = (pix_y[9:6]==5) &&
                    (5<=pix_x[9:5]) && (pix_x[9:5]<=7);
   assign row_addr_C_S = pix_y[5:2];
   assign bit_addr_C_S = pix_x[4:2];
   always @*
      case(pix_x[8:5])
			4'h5: char_addr_C_S = 7'h3a;//:
			4'h6: char_addr_C_S = {3'b011,R_Cronometro_Segundo[7:4]}; // Decenas horas
         4'h7: char_addr_C_S = {3'b011,R_Cronometro_Segundo[3:0]}; // Unidades horas
         default: char_addr_C_S = 7'h00; // 
      endcase			
		
  always @(posedge clock_nexys)
   begin
      text_rgb = 3'b000;  //Negro
      if (Fecha)
         begin
            char_addr = char_addr_F;
            row_addr = row_addr_F;
            bit_addr = bit_addr_F;
            if (font_bit)
               text_rgb = 3'b011;
					else
				text_rgb = 3'b111;
         end
		else if (Dia_Fecha)
         begin
            char_addr = char_addr_D_F;
            row_addr = row_addr_D_F;
            bit_addr = bit_addr_D_F;
            if (font_bit)
               text_rgb = 3'b011;
					else if (control == 4'd3)
					text_rgb = 3'b100;
					
         end
		else if (Mes_Fecha)
         begin
            char_addr = char_addr_M_F;
            row_addr = row_addr_M_F;
            bit_addr = bit_addr_M_F;
            if (font_bit)
               text_rgb = 3'b011;
				else if (control == 4'd4)
					text_rgb = 3'b100;
        end
		  	else if (Ano_Fecha)
         begin
            char_addr = char_addr_A_F;
            row_addr = row_addr_A_F;
            bit_addr = bit_addr_A_F;
            if (font_bit)
               text_rgb = 3'b011;
					else if (control == 4'd5)
					text_rgb = 3'b100;
        end
      else if (Hora)
         begin
            char_addr = char_addr_H;
            row_addr = row_addr_H;
            bit_addr = bit_addr_H;
            if (font_bit)
               text_rgb = 3'b011;
				else
				text_rgb = 3'b111;
         end
		 else if (Hora_H)
         begin
            char_addr = char_addr_H_H;
            row_addr = row_addr_H_H;
            bit_addr = bit_addr_H_H;
            if (font_bit)
               text_rgb = 3'b011;
					else if (control == 4'd2)
					text_rgb = 3'b100;
					
         end
		 else if (Hora_S)
         begin
            char_addr = char_addr_H_S;
            row_addr = row_addr_H_S;
            bit_addr = bit_addr_H_S;
            if (font_bit)
               text_rgb = 3'b011;
				else if (control == 4'd0)
					text_rgb = 3'b100;
         end
		 else if (Hora_M)
         begin
            char_addr = char_addr_H_M;
            row_addr = row_addr_H_M;
            bit_addr = bit_addr_H_M;
            if (font_bit)
               text_rgb = 3'b011;
					else if (control == 4'd1)
					text_rgb = 3'b100;
         end
		 else if (Hora_AM)
         begin
            char_addr = char_addr_H_Am;
            row_addr = row_addr_H_Am;
            bit_addr = bit_addr_H_Am;
            if (font_bit)
               text_rgb = 3'b011;
				else if(R_Hora_Hora[7])
				text_rgb = 3'b111;
         end
		 else if (Hora_PM)
         begin
            char_addr = char_addr_H_Pm;
            row_addr = row_addr_H_Pm;
            bit_addr = bit_addr_H_Pm;
            if (font_bit)
               text_rgb = 3'b011;
					else if(~R_Hora_Hora[7])
				text_rgb = 3'b111;
         end	
		 else if (Hora_b)
         begin
            char_addr = char_addr_H_b;
            row_addr = row_addr_H_b;
            bit_addr = bit_addr_H_b;
            if (font_bit)
               text_rgb = 3'b011;
				end
		 else if (CRONOMETRO)
         begin
            char_addr = char_addr_C;
            row_addr = row_addr_C;
            bit_addr = bit_addr_C;
            if (font_bit)
               text_rgb = 3'b011;
					else
				text_rgb = 3'b111;
         end
      else if (Alarma)
         begin
            char_addr = char_addr_Al;
            row_addr = row_addr_Al;
            bit_addr = bit_addr_Al;
            if (font_bit)
					if(clk_o[25])
               text_rgb = 3'b001;
					else
					text_rgb = 3'b100;
				else
				text_rgb = 3'b000;
         end
      else if (CRONOMETRO_H)
         begin
            char_addr = char_addr_C_H;
            row_addr = row_addr_C_H;
            bit_addr = bit_addr_C_H;
            if (font_bit)
               text_rgb = 3'b011;
				else if (control == 4'd8)
					text_rgb = 3'b100;
				
         end
		else if (CRONOMETRO_M)
         begin
            char_addr = char_addr_C_M;
            row_addr = row_addr_C_M;
            bit_addr = bit_addr_C_M;
            if (font_bit)
               text_rgb = 3'b011;
				else if (control == 4'd7)
					text_rgb = 3'b100;
					
         end
		else if (CRONOMETRO_S)
         begin
            char_addr = char_addr_C_S;
            row_addr = row_addr_C_S;
            bit_addr = bit_addr_C_S;
            if (font_bit)
               text_rgb = 3'b011;
				else if (control == 4'd6)
					text_rgb = 3'b100;	
         end
   end
   
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

endmodule
