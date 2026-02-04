module tb_single_stage_pipe;

  logic clk;
  logic rst_n;

  logic        in_valid;
  logic        in_ready;
  logic [31:0] in_data;

  logic        out_valid;
  logic        out_ready;
  logic [31:0] out_data;

  // DUT
  single_stage_pipe dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .in_valid  (in_valid),
    .in_ready  (in_ready),
    .in_data   (in_data),
    .out_valid (out_valid),
    .out_ready (out_ready),
    .out_data  (out_data)
  );

  // Clock
  always #5 clk = ~clk;
 
  initial begin
    clk = 0;
    rst_n = 0;
    in_valid = 0;
    in_data  = 0;
    out_ready = 0;

    // Reset
    #12;
    rst_n = 1;

    
    $display("PUSH ONLY");
    #10;
    in_valid = 1;
    in_data  = 32'hABCC_1111;

    #10;
    in_valid = 0;

    
    $display("POP ONLY");
    #11;
    out_ready = 1;

    #13;
    out_ready = 0;

   
    $display("BACKPRESSURE");
    #12;
    in_valid = 1;
    in_data  = 32'hBAAB_2222;
    out_ready = 0;

    #27; // hold

    out_ready = 1;
    #10;
    out_ready = 0;
    in_valid  = 0;

   
    $display("PUSH & POP SAME CYCLE");
    #18;
    in_valid  = 1;
    in_data   = 32'hCCA_3333;
    out_ready = 1;

    #16;
    in_valid  = 0;
    out_ready = 0;
    #5;
    rst_n=0;
    
    #3;
    rst_n=1;

    #100;
    $finish;
    
  end
  initial begin
    $dumpfile("single_stage_pipe.vcd");
  $dumpvars(0, tb_single_stage_pipe);
end

endmodule
