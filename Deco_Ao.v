`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:38 04/10/2016 
// Design Name: 
// Module Name:    Deco_Ao 
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
module Deco_Ao(input Clock,
    input Reset,
    input [6:0] Ref,
    output [7:0] Dato_out
    );

reg [7:0] Out;

always @(posedge Clock)

	if (Reset)
		Out <= 8'h00;
	else 
	begin
		
	case (Ref)
		
		7'd0 : Out <= 8'h00;
		7'd1 : Out <= 8'h01;
		7'd2 : Out <= 8'h02;
		7'd3 : Out <= 8'h03;
		7'd4 : Out <= 8'h04;
		7'd5 : Out <= 8'h05;
		7'd6 : Out <= 8'h06;
		7'd7 : Out <= 8'h07;
		7'd8 : Out <= 8'h08;
		7'd9 : Out <= 8'h09;
		7'd10 : Out <= 8'h10;
		7'd11 : Out <= 8'h11;
		7'd12 : Out <= 8'h12;
		7'd13 : Out <= 8'h13;
		7'd14 : Out <= 8'h14;
		7'd15 : Out <= 8'h15;
		7'd16 : Out <= 8'h16;
		7'd17 : Out <= 8'h17;
		7'd18 : Out <= 8'h18;
		7'd19 : Out <= 8'h19;
		7'd20 : Out <= 8'h20;
		7'd21 : Out <= 8'h21;
		7'd22 : Out <= 8'h22;
		7'd23 : Out <= 8'h23;
		7'd24 : Out <= 8'h24;
		7'd25 : Out <= 8'h25;
		7'd26 : Out <= 8'h26;
		7'd27 : Out <= 8'h27;
		7'd28 : Out <= 8'h28;
		7'd29 : Out <= 8'h29;
		7'd30 : Out <= 8'h30;
		7'd31 : Out <= 8'h31;
		7'd32 : Out <= 8'h32;
		7'd33 : Out <= 8'h33;
		7'd34 : Out <= 8'h34;
		7'd35 : Out <= 8'h35;
		7'd36 : Out <= 8'h36;
		7'd37 : Out <= 8'h37;
		7'd38 : Out <= 8'h38;
		7'd39 : Out <= 8'h39;
		7'd40 : Out <= 8'h40;
		7'd41 : Out <= 8'h41;
		7'd42 : Out <= 8'h42;
		7'd43 : Out <= 8'h43;
		7'd44 : Out <= 8'h44;
		7'd45 : Out <= 8'h45;
		7'd46 : Out <= 8'h46;
		7'd47 : Out <= 8'h47;
		7'd48 : Out <= 8'h48;
		7'd49 : Out <= 8'h49;
		7'd50 : Out <= 8'h50;
		7'd51 : Out <= 8'h51;
		7'd52 : Out <= 8'h52;
		7'd53 : Out <= 8'h53;
		7'd54 : Out <= 8'h54;
		7'd55 : Out <= 8'h55;
		7'd56 : Out <= 8'h56;
		7'd57 : Out <= 8'h57;
		7'd58 : Out <= 8'h58;
		7'd59 : Out <= 8'h59;
		7'd60 : Out <= 8'h60;
		7'd61 : Out <= 8'h61;
		7'd62 : Out <= 8'h62;
		7'd63 : Out <= 8'h63;
		7'd64 : Out <= 8'h64;
		7'd65 : Out <= 8'h65;
		7'd66 : Out <= 8'h66;
		7'd67 : Out <= 8'h67;
		7'd68 : Out <= 8'h68;
		7'd69 : Out <= 8'h69;
		7'd70 : Out <= 8'h70;
		7'd71 : Out <= 8'h71;
		7'd72 : Out <= 8'h72;
		7'd73 : Out <= 8'h73;
		7'd74 : Out <= 8'h74;
		7'd75 : Out <= 8'h75;
		7'd76 : Out <= 8'h76;
		7'd77 : Out <= 8'h77;
		7'd78 : Out <= 8'h78;
		7'd79 : Out <= 8'h79;
		7'd80 : Out <= 8'h80;
		7'd81 : Out <= 8'h81;
		7'd82 : Out <= 8'h82;
		7'd83 : Out <= 8'h83;
		7'd84 : Out <= 8'h84;
		7'd85 : Out <= 8'h85;
		7'd86 : Out <= 8'h86;
		7'd87 : Out <= 8'h87;
		7'd88 : Out <= 8'h88;
		7'd89 : Out <= 8'h89;
		7'd90 : Out <= 8'h90;
		7'd91 : Out <= 8'h91;
		7'd92 : Out <= 8'h92;
		7'd93 : Out <= 8'h93;
		7'd94 : Out <= 8'h94;
		7'd95 : Out <= 8'h95;
		7'd96 : Out <= 8'h96;
		7'd97 : Out <= 8'h97;
		7'd98 : Out <= 8'h98;
		7'd99 : Out <= 8'h99;
		default : Out <= 8'h00;
		
		endcase
		end
assign Dato_out = Out;
endmodule
