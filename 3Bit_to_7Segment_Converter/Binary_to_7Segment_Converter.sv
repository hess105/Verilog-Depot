`default_nettype none

module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
  
  // Call module
  display v1 (.in(pb[2:0]), .out(ss0[6:0]));
  
endmodule

module display (

  input logic [2:0]in,
  output logic [6:0]out  

);

// Top Line
assign out[0] = ((~(in[2])) & (~(in[0]))) | in[1] | (in[0] & in[2]);

// Upper Right-most Line
assign out[1] = (~in[2]) | ((~in[1]) & (~in[0])) | (in[0] & in[1]);

// Lower Right-most Line
assign out[2] = (in[2] | (~in[1]) | in[0]);

// Bottom Line
assign out[3] = (in[2] & (~in[1]) & in[0]) | (in[1] & (~in[2])) | (in[1] & (~in[0])) | ((~in[0]) & (~in[2]));

// Lower Left-most Line
assign out[4] = ((~in[0]) & in[1]) | ((~in[0]) & (~in[2]));

// Upper Left-most Line
assign out[5] = (in[2] & (~in[0])) | ((~in[1]) & (~in[0])) | (in[2] & (~in[1]));

// Middle Line
assign out[6] = ((~in[2]) & in[1]) | (in[2] & (~in[0])) | (in[2] & (~in[1]));

endmodule
