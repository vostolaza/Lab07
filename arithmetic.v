module arithmetic (A, B, opcode, out);
    input[31:0] A, B;
    input [2:0] opcode;
    output [31:0] out;
    reg [31:0] out;
    reg [31:0] aux;

    parameter add = 3'b010, sub = 3'b110, slt = 3'b111;
    always @ (A or B or opcode) begin
        casex (opcode)
            add: out = A + B;
            sub: out = A - B;
            slt: begin
                    if (A[31] ^ B[31])
                        out = A[31];
                    else
                        begin
                            aux = A-B;
                            out = aux[31];
                        end
                 end
            default: out = 31'b0;
        endcase
    end

endmodule



