`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:36:32 09/13/2015 
// Design Name: 
// Module Name:    mux 
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
`include "global.v"
module mux(sec0,sec1,min0,min1,hour0,hour1,day0,day1,month0,month1,year0,year1,year2,
dig0,dig1,dig2,dig3,AMPM,sec,hour,year99
    );

input  [`BCD_BIT_WIDTH-1:0] sec0,sec1,min0,min1,hour0,hour1,day0,day1,month0,month1,year0,year1,year2;
input AMPM,sec,hour,year99;
output [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3;



reg [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3,out0,out1,out2,out3;

always@*
begin
	if(sec==`ENABLED && AMPM==1'd1 && hour==`DISABLED && year99==`DISABLED)
	begin
		dig3=4'd0;
		dig2=4'd0;
		dig1=sec1;
		dig0=sec0;
	end
	else if(sec==`DISABLED && AMPM==1'd0 && hour==1'd1 && year99==`DISABLED)
	begin
		if((hour1==`BCD_ZERO)&&(hour0<=`BCD_NINE))
		begin
			dig3=4'd10;
			dig2=4'd15;
			dig1=hour1;
			dig0=hour0;
		end
		else if((hour1==`BCD_ONE)&&(hour0<=`BCD_ONE))
		begin
			dig3=4'd10;
			dig2=4'd15;
			dig1=hour1;
			dig0=hour0;
		end
		else if((hour1==`BCD_ONE)&&(hour0==`BCD_TWO))
		begin
			dig3=4'd11;
			dig2=4'd15;
			dig1=hour1;
			dig0=hour0;
		end
		else if((hour1==4'd2)&&(hour0<=4'd1))
		begin
			dig3=4'd11;
			dig2=4'd15;
			dig1=hour1-4'd2;
			dig0=hour0+4'd8;
		end
		else
		begin
			dig3=4'd11;
			dig2=4'd15;
			dig1=hour1-4'd1;
			dig0=hour0-4'd2;
		end
	end
	else if(sec==`DISABLED && AMPM==1'd1 && hour==`ENABLED && year99==`DISABLED)
	begin
		dig3=hour1;
		dig2=hour0;
		dig1=min1;
		dig0=min0;
	end
	else if(sec==`DISABLED && AMPM==1'd1 && hour==`DISABLED && year99==`ENABLED)
	begin
		dig3=4'd2;
		dig2=year2;
		dig1=year1;
		dig0=year0;
	end
	else
	begin
		dig3=month1;
		dig2=month0;
		dig1=day1;
		dig0=day0;
	end
end

/*always@*
begin
	if(sec==`DISABLED && hour==`ENABLED)
	begin
		if((hour1<=`BCD_ONE)&&(hour0<=`BCD_ONE))
		begin
			out3=4'd10;
			out2=4'd15;
			out1=hour1;
			out0=hour0;
		end
		else if((hour1==`BCD_ONE)&&(hour0==`BCD_TWO))
		begin
			out3=4'd11;
			out2=4'd15;
			out1=hour1;
			out0=hour0;
		end
		else
		begin
			out3=4'd11;
			out2=4'd15;
			out1=hour1-4'd1;
			out0=hour0-4'd2;
		end
	end
	else
	begin
		out3=hour1;
		out2=hour0;
		out1=min1;
		out0=min0;
	end
end*/

endmodule
