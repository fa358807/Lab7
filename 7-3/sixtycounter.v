`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:57:30 04/15/2013 
// Design Name: 
// Module Name:    sixtycounter 
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
module sixtycounter(
sec1, // digit 1 for second
sec0, // digit 0 for second
min1, // digit 1 for minute
min0, // digit 0 for minute
hour1,// digit 1 for hour
hour0,// digit 0 for hour
day1,
day0,
month1,
month0,
year2,
year1,
year0,
clk, // global clock
rst_n //active low reset

);

// outputs
output [`BCD_BIT_WIDTH-1:0] sec1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] sec0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] min1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] min0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] hour1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] hour0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] day1; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] day0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] month1; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] month0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] year2; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] year1; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] year0; // digit 0 for second
// inputs
input clk; // global clock signal
input rst_n; // low active reset
// temporatory nets
reg load_def_sec,load_def_min,load_def_hour,load_def_day,load_def_month,load_def_year; // enabled to load second value
reg out_sec1,out_min1,out_hour1,out_day1,out_month1;
wire cout_sec0, cout_sec1, cout_min0, cout_min1, cout_hour0, cout_hour1,cout_day0,cout_day1,cout_month0,cout_month1,cout_year0,cout_year1,cout_year2; // BCD counter carryout

// return from 59 to 00
always @(sec0 or sec1)
begin
  if ((sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_sec = `ENABLED;
	 out_sec1 = `ENABLED;
	end
  else
  begin
    load_def_sec = `DISABLED;
	 out_sec1 = `DISABLED;
  end
end

always @(min0 or min1)
begin
  if ((min1==`BCD_FIVE)&&(min0==`BCD_NINE)
  &&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_min = `ENABLED;
	 out_min1 = `ENABLED;
  end
  else
  begin
    load_def_min = `DISABLED;
	 out_min1 = `DISABLED;
  end
end

  
always @(hour0 or hour1)
begin
  if ((hour1==`BCD_TWO)&&(hour0==`BCD_THREE)
  &&(min1==`BCD_FIVE)&&(min0==`BCD_NINE)
  &&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_hour = `ENABLED;
	 out_hour1 = `ENABLED;
  end
  else
  begin
    load_def_hour = `DISABLED;
	 out_hour1 = `DISABLED;
  end
end

always @(day0 or day1)
begin
  if ((((month1==`BCD_ZERO)&&((month0==`BCD_ONE)||(month0==`BCD_THREE)||(month0==`BCD_FIVE)||(month0==`BCD_SEVEN)||(month0==`BCD_EIGHT)))
  ||((month1==`BCD_ONE)&&((month0==`BCD_ZERO)||(month0==`BCD_TWO))))
  &&(day1==`BCD_THREE)&&(day0==`BCD_ONE)
  &&(hour1==`BCD_TWO)&&(hour0==`BCD_THREE)
  &&(min1==`BCD_FIVE)&&(min0==`BCD_NINE)
  &&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_day = `ENABLED;
	 out_day1 = `ENABLED;
  end
  else if ((((month1==`BCD_ZERO)&&((month0==`BCD_FOUR)||(month0==`BCD_SIX)||(month0==`BCD_NINE)))
  ||((month1==`BCD_ONE)&&((month0==`BCD_ONE))))
  &&(day1==`BCD_THREE)&&(day0==`BCD_ZERO)
  &&(hour1==`BCD_TWO)&&(hour0==`BCD_THREE)
  &&(min1==`BCD_FIVE)&&(min0==`BCD_NINE)
  &&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_day = `ENABLED;
	 out_day1 = `ENABLED;
  end
  else if((month1==`BCD_ZERO)&&(month0==`BCD_TWO)
  &&(day1==`BCD_TWO)&&(day0==`BCD_NINE)
  &&(hour1==`BCD_TWO)&&(hour0==`BCD_THREE)
  &&(min1==`BCD_FIVE)&&(min0==`BCD_NINE)
  &&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
	 load_def_day = `ENABLED;
	 out_day1 = `ENABLED;
  end
  else
  begin
    load_def_day = `DISABLED;
	 out_day1 = `DISABLED;
  end
end

always @(month0 or month1)
begin
  if ((month1==`BCD_ONE)&&(month0==`BCD_TWO)
  &&(day1==`BCD_THREE)&&(day0==`BCD_ONE)
  &&(hour1==`BCD_TWO)&&(hour0==`BCD_THREE)
  &&(min1==`BCD_FIVE)&&(min0==`BCD_NINE)
  &&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_month = `ENABLED;
	 out_month1 = `ENABLED;
  end
  else
  begin
    load_def_month = `DISABLED;
	 out_month1 = `DISABLED;
  end
end



//**************************************************************
// counter for second
//**************************************************************
// counter for digit 0
hcounter Udig0(
  .value(sec0),  // digit 0 of second
  .carry(cout_sec0),  // carry out for digit 0
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(`ENABLED),  // always increasing
  .load_default(load_def_sec),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

// counter for digit 1
hcounter Udig1(
  .value(sec1),  // digit 1 of second
  .carry(cout_sec1),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_sec0),  // increasing when digit 0 carry out
  .load_default(load_def_sec),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);
//**************************************************************
// counter for minute
//**************************************************************
hcounter Umin0(
  .value(min0),  // digit 1 of second
  .carry(cout_min0),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_sec1),  // increasing when digit 0 carry out
  .load_default(load_def_min),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Umin1(
  .value(min1),  // digit 1 of second
  .carry(cout_min1),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_min0),  // increasing when digit 0 carry out
  .load_default(load_def_min),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);
//**************************************************************
// counter for hour
//**************************************************************
hcounter Uhour0(
  .value(hour0),  // digit 1 of second
  .carry(cout_hour0),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_min1),  // increasing when digit 0 carry out
  .load_default(load_def_hour),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Uhour1(
  .value(hour1),  // digit 1 of second
  .carry(cout_hour1),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_hour0),  // increasing when digit 0 carry out
  .load_default(load_def_hour),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);
//**************************************************************
// counter for day
//**************************************************************
hcounter Uday0(
  .value(day0),  // digit 1 of second
  .carry(cout_day0),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_hour1),  // increasing when digit 0 carry out
  .load_default(load_def_day),  // enable load default value
  .def_value(`BCD_ONE) // default value for counter
);

hcounter Uday1(
  .value(day1),  // digit 1 of second
  .carry(cout_day1),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_day0),  // increasing when digit 0 carry out
  .load_default(load_def_day),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);
//**************************************************************
// counter for month
//**************************************************************
hcounter Umonth0(
  .value(month0),  // digit 1 of second
  .carry(cout_month0),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_day1),  // increasing when digit 0 carry out
  .load_default(load_def_month),  // enable load default value
  .def_value(`BCD_ONE) // default value for counter
);

hcounter Umonth1(
  .value(month1),  // digit 1 of second
  .carry(cout_month1),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_month0),  // increasing when digit 0 carry out
  .load_default(load_def_month),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);
//**************************************************************
// counter for year
//**************************************************************
hcounter Uyear0(
  .value(year0),  // digit 1 of second
  .carry(cout_year0),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_month1),  // increasing when digit 0 carry out
  .load_default(load_def_year),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Uyear1(
  .value(year1),  // digit 1 of second
  .carry(cout_year1),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_year0),  // increasing when digit 0 carry out
  .load_default(load_def_year),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Uyear2(
  .value(year2),  // digit 1 of second
  .carry(cout_year2),  // carry out for digit 1
  .clk(clk),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_year1),  // increasing when digit 0 carry out
  .load_default(load_def_year),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);
endmodule
