`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:34 04/09/2016 
// Design Name: 
// Module Name:    Counter_Ao_UpDown 
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
module Counter_Ao_UpDown(
	 input Clock,
    input Enable,
    input Reset,
    input down,
    input up,
    output [6:0] out4
    );
	 
reg [6:0] out_f ;

always @(posedge Clock)
begin
	if (Reset)
		out_f <= 7'd0;
	else
	begin
		if (Enable) begin 
			if (up) begin
				if(out_f == 7'd99)
					out_f <= out_f; 
				else
					out_f <= out_f + 1'b1;
			end
	
			if (down) begin 
				if(out_f==7'd0)
					out_f <= out_f; 
			else
				out_f <= out_f - 1'b1;
			end

		end
  end
end
assign out4 = out_f;
endmodule
