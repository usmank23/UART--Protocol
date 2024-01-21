`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Self
// Engineer: Usman Khan
// 
// Create Date: 01/16/2024 12:03:18 AM
// Design Name: 
// Module Name: startbit_detector_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module startbit_detector_tb();
reg clk, rxbit;
wire out;

startbit_detector dut(rxbit, out, clk);

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
rxbit = 1;
#20;
rxbit = 0;
#20;
end

initial begin
$monitor("rxbit = %b, out = %b", rxbit, out);
#160;
$finish;
end
endmodule
