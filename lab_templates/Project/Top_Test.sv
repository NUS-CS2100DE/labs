`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Simple simulation testbench for the LED chaser program.
//////////////////////////////////////////////////////////////////////////////////

module Top_Test;

    logic clk;
    logic btnCpuReset;
    logic btnC;
    logic btnU;
    logic btnL;
    logic btnR;
    logic btnD;
    logic [15:0] sw;

    logic [15:0] led;
    logic [6:0] seg;
    logic [7:0] an;

    logic [15:0] expected_led;
    integer led_updates;

    Top_MMC dut (
        .clk(clk),
        .btnCpuReset(btnCpuReset),
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .sw(sw),
        .led(led),
        .seg(seg),
        .an(an)
    );

    initial begin
        $dumpfile("top_test.vcd");
        $dumpvars(0, Top_Test);
    end

    initial begin
        clk = 1'b0;
        btnCpuReset = 1'b0;
        btnC = 1'b0;
        btnU = 1'b0;
        btnL = 1'b0;
        btnR = 1'b0;
        btnD = 1'b0;
        sw = 16'h00AA;
        expected_led = 16'h0001;
        led_updates = 0;

        repeat (2) @(posedge clk);
        btnCpuReset = 1'b1;
    end

    always #5 clk = ~clk;

    always @(led) begin
        if (btnCpuReset && (led != 16'h0000)) begin
            $display("%0t ns: LED = %h", $time, led);
            if (led !== expected_led) begin
                $fatal(1, "Unexpected LED value. Expected %h, got %h", expected_led, led);
            end

            led_updates = led_updates + 1;
            if (expected_led == 16'h8000) begin
                expected_led = 16'h0001;
            end
            else begin
                expected_led = expected_led << 1;
            end

            if (led_updates == 6) begin
                $display("PASS: observed %0d correct LED updates", led_updates);
                $finish;
            end
        end
    end

    initial begin
        #100000;
        $fatal(1, "Timed out waiting for LED updates");
    end

endmodule
