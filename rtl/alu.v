module ALU (A, B, Ctrl, Y, C, N, Z);
    input [7:0] A;
    input [7:0] B;
    input [2:0] Ctrl;
    output reg [7:0] Y;
    output reg C;
    output reg N;
    output reg Z;

    always @(*) begin
        case (Ctrl)
            3'b000: begin
                Y = A & B;
                C = 0;
                N = 0;
                Z = (Y == 0);
            end
            3'b001: begin
                Y = A | B;
                C = 0;
                N = 0;
                Z = (Y == 0);
            end
            3'b010: begin
                {C, Y} = A + B;
                N = 0;
                Z = (Y == 0);
            end
            3'b110: begin
                C = 0;
                {C, Y} = A - B;
                N = C;
                Z = (Y == 0);
            end
            default: begin
                Y = 8'bx;
                C = 1'bx;
                N = 1'bx;
                Z = 1'bx;
            end
        endcase
    end
endmodule

