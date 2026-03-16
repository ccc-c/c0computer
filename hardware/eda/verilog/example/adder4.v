`timescale 1ns / 1ps  // 設定時間單位與精度

module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    // 使用邏輯運算式實作
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module adder_4bit (
    input [3:0] A,      // 4位元輸入 A
    input [3:0] B,      // 4位元輸入 B
    input cin,          // 初始進位 (通常為0)
    output [3:0] S,     // 4位元和輸出
    output cout         // 最終進位輸出
);
    // 定義內部連線，用於傳遞進位訊號
    wire c1, c2, c3;

    // 區塊化實例化四個全加器
    // full_adder 實例名稱 (連接埠對應)
    
    full_adder fa0 (
        .a(A[0]), .b(B[0]), .cin(cin), .sum(S[0]), .cout(c1)
    );

    full_adder fa1 (
        .a(A[1]), .b(B[1]), .cin(c1), .sum(S[1]), .cout(c2)
    );

    full_adder fa2 (
        .a(A[2]), .b(B[2]), .cin(c2), .sum(S[2]), .cout(c3)
    );

    full_adder fa3 (
        .a(A[3]), .b(B[3]), .cin(c3), .sum(S[3]), .cout(cout)
    );

endmodule

module tb_adder_4bit;

    // 1. 宣告連接到被測元件 (DUT) 的暫存器與線路
    reg [3:0] A;
    reg [3:0] B;
    reg cin;
    wire [3:0] S;
    wire cout;

    // 2. 實例化被測元件 (Device Under Test)
    adder_4bit uut (
        .A(A), 
        .B(B), 
        .cin(cin), 
        .S(S), 
        .cout(cout)
    );

    // 3. 測試邏輯設計
    initial begin
        // 顯示標題於控制台
        $display("Time\t A \t B \t cin | S \t cout");
        $display("---------------------------------------");

        // 案例 1: 簡單加法 (2 + 3)
        A = 4'd2; B = 4'd3; cin = 1'b0;
        #10; // 等待 10 個時段單位
        $display("%0t\t %d \t %d \t %b   | %d \t %b", $time, A, B, cin, S, cout);

        // 案例 2: 邊界測試 (15 + 1) 應產生溢位
        A = 4'd15; B = 4'd1; cin = 1'b0;
        #10;
        $display("%0t\t %d \t %d \t %b   | %d \t %b", $time, A, B, cin, S, cout);

        // 案例 3: 包含初始進位 (5 + 5 + 1)
        A = 4'd5; B = 4'd5; cin = 1'b1;
        #10;
        $display("%0t\t %d \t %d \t %b   | %d \t %b", $time, A, B, cin, S, cout);

        // 案例 4: 最大值測試 (15 + 15 + 1)
        A = 4'hf; B = 4'hf; cin = 1'b1;
        #10;
        $display("%0t\t %d \t %d \t %b   | %d \t %b", $time, A, B, cin, S, cout);

        // 結束模擬
        #10;
        $finish;
    end

endmodule