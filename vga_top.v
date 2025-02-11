`timescale 1ns / 1ps

module vga_controller_tb;

    // Testbench Signals
    reg clk;
    reg reset;
    wire h_sync;
    wire v_sync;
    wire [2:0] rgb;

    // Instantiate the VGA Controller
    vga_controller uut (
        .clk(clk),
        .reset(reset),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .rgb(rgb)
    );

    // Generate 100MHz Clock
    always #5 clk = ~clk;  // Toggle every 5ns (100MHz clock)

    // Test Procedure
    initial begin
        $display("Starting VGA Controller Test...");
        clk = 0;
        reset = 1;
        #50 reset = 0;  // Ensure reset releases properly

        // Run simulation for a few frames
        #5000000; 
        
        $display("VGA Test Completed.");
        $stop;
    end

    // Monitor Signals
    initial begin
        $monitor("Time=%0t | H_COUNTER=%d | V_COUNTER=%d | H_SYNC=%b | V_SYNC=%b | RGB=%b", 
                 $time, uut.h_counter, uut.v_counter, h_sync, v_sync, rgb);
    end

endmodule
