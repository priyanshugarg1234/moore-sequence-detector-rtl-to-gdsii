module tb_seq_detect;
    reg clk, rst, din;
    wire dout;

    seq_detect uut(.clk(clk), .rst(rst), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1; din = 0;
        #10 rst = 0;

        // Input sequence: 1 0 1 1 -> should detect sequence at last bit
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        
        // Some other inputs
        #20 din = 0;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1; // again sequence
        
        #20 $stop;
    end
endmodule
