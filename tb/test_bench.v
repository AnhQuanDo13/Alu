module test_bench;
    parameter BIT = 8;
    parameter BIT_Ctrl = 3;
    reg [BIT-1:0] A;
    reg [BIT-1:0] B;
    reg [2:0] Ctrl;
    wire [BIT-1:0] Y;
    wire N;
    wire Z;
    wire C;
    reg [BIT-1:0] res;
    reg C_exp, N_exp, Z_exp;

    ALU dut (.*);

initial begin
    A = 8'b0;
    B = 8'b0;
    Ctrl = 3'b0;

for (integer i = 1; i < 101; i++) begin
    if (i == 100) begin
        A = 8'b00000000;
        B = 8'b00000000;
        Ctrl = 3'b000;
    end else if (i == 99) begin
        A = {BIT{1'b1}};
        B = {BIT{1'b1}};
        Ctrl = 3'b000;
    end else if (i == 98) begin
        A = $urandom_range(0, {BIT{1'b1}});
        B = $urandom_range(0, {BIT{1'b1}});
        Ctrl = 3'b000;
    end else if (i == 97) begin
	A = 8'b00000000;
        B = 8'b00000000;
        Ctrl = 3'b001;
    end else if (i == 96) begin
	A = {BIT{1'b1}};
        B = {BIT{1'b1}};
        Ctrl = 3'b001;
    end else if (i == 95) begin
        A = $urandom_range(0, {BIT{1'b1}});
        B = $urandom_range(0, {BIT{1'b1}});
        Ctrl = 3'b001;
    end else if (i == 94) begin
	A = 8'b00000000;
        B = 8'b00000000;
        Ctrl = 3'b010;
    end else if (i == 93) begin
	A = {BIT{1'b1}};
        B = {BIT{1'b1}};
        Ctrl = 3'b010;
    end else if (i == 92) begin
        A = $urandom_range(0, {BIT{1'b1}});
        B = $urandom_range(0, {BIT{1'b1}});
        Ctrl = 3'b010;
    end else if (i == 91) begin
	A = 8'b00000000;
        B = 8'b00000000;
        Ctrl = 3'b110;
    end else if (i == 90) begin
	A = {BIT{1'b1}};
        B = {BIT{1'b1}};
        Ctrl = 3'b110;
    end else if (i == 89) begin
        A = $urandom_range(0, {BIT{1'b1}});
        B = $urandom_range(0, {BIT{1'b1}});
        Ctrl = 3'b110;
    end else begin
        A = $urandom_range(0, {BIT{1'b1}});
        B = $urandom_range(0, {BIT{1'b1}});
        Ctrl = $urandom_range(0, {BIT_Ctrl{1'b1}});
    end
    #5;

    $display("=======================================================");
    $display("Case:%d  A = %d, B = %d, Ctrl = %b", i, A, B, Ctrl);
    $display("Case:%d  A = %b, B = %b, Ctrl = %b", i, A, B, Ctrl);
        if (Ctrl == 3'b000) begin
    $display("-----------------------Bitwise AND---------------------");
            res = A & B;
            C_exp = 0;
            N_exp = 0;
            Z_exp = (res == 0);
        end else if (Ctrl == 3'b001) begin
    $display("-----------------------Bitwise OR----------------------");
            res = A | B;
            C_exp = 0;
            N_exp = 0;
            Z_exp = (res == 0);
        end else if (Ctrl == 3'b010) begin
    $display("-----------------------Addition------------------------");
            {C_exp, res} = A + B;
            N_exp = 0;
            Z_exp = (res == 0);
        end else if (Ctrl == 3'b110) begin
    $display("-----------------------Subtraction---------------------");
            C_exp = 0;	
            {C_exp, res} = A - B;
            N_exp = C_exp;
            Z_exp = (res == 0);
        end else begin
    $display("-----------------------NOTHING HERE--------------------");
            res = 8'bx;
            C_exp = 1'bx;
            N_exp = 1'bx;
            Z_exp = 1'bx;
        end

    $display("Expected-dec: Y = %d, C = %b, N = %b, Z = %b", res, C_exp, N_exp, Z_exp);
    $display("Actual-dec:   Y = %d, C = %b, N = %b, Z = %b", Y, C, N, Z);
    $display("Expected-bit: Y = %b, C = %b, N = %b, Z = %b", res, C_exp, N_exp, Z_exp);
    $display("Actual-bit:   Y = %b, C = %b, N = %b, Z = %b", Y, C, N, Z);

        if (res === Y && C_exp === C && N_exp === N && Z_exp === Z) begin
            $display(">>>>>>>>>>>>>>>>>>>>>>>>  PASS <<<<<<<<<<<<<<<<<<<<<<<<");
        end else begin
            $display(">>>>>>>>>>>>>>>>>>>>>>>>  FAIL <<<<<<<<<<<<<<<<<<<<<<<<");
            $finish;
        end
    end

    $display("=======================================================");
    $display("===================ALL PASS============================");
    $display("=======================================================");
    #100;
    $finish;
end

endmodule

