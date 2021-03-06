module testbench();

  reg        clk;
  reg        reset;

  wire [31:0] writedata, dataadr;
  wire        memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);

  // initialize test
  initial
    begin
      reset <= 1; # 10; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check that 32'hFFFF7F02 gets written to address 54
  always@(negedge clk)
    begin
      if(memwrite) begin
        if(writedata === 32'hFFFF7F02 && dataadr == 84) begin
          $display("Simulation succeeded");
          $stop;
        end else if (dataadr != 80) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end
initial begin
        $dumpfile("mips2.vcd");
        $dumpvars;
end

endmodule
