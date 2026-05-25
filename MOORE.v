module seq_detect(
    input clk,
    input rst,
    input din,
    output reg dout
);

    reg [2:0] state, next;

    localparam
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next;
    end

    always @(*) begin
        dout = 0;
        case (state)
            S0: if (din) next = S1; else next = S0;
            S1: if (din) next = S1; else next = S2;
            S2: if (din) next = S3; else next = S0;
            S3: if (din) next = S4; else next = S2;
            S4: begin
                dout = 1;
                if (din) next = S1; else next = S2;
            end
            default: next = S0;
        endcase
    end
endmodule
