// Code your design here
module single_stage_pipe #(
  parameter int WIDTH = 32
)(
  input  logic               clk,
  input  logic               rst_n,

  input  logic               out_ready,
  input  logic               in_valid,
  input  logic [WIDTH-1:0]   in_data,

  output logic               in_ready,
  output logic               out_valid,
 
  output logic [WIDTH-1:0]   out_data
);

  logic               full;
  logic [WIDTH-1:0]   data_r;

  wire push = in_valid  && in_ready;
  wire pop  = out_valid && out_ready;

 
  assign out_valid = full;
  assign out_data  = data_r;

  assign in_ready  = ~full || pop;

 
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      full   <= 1'b0;
      data_r <= '0;
    end else begin
      case ({push, pop})
        2'b10: begin
         
          data_r <= in_data;
          full   <= 1'b1;
        end
        2'b01: begin
        
          full <= 1'b0;
        end
        2'b11: begin
          
          data_r <= in_data;
          full   <= 1'b1;
        end
        default: ; 
      endcase
    end
  end

endmodule
