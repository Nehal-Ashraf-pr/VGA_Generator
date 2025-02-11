/* `timescale 1ns / 1ps

module vga_controller(
    input wire clk,             // 100MHz Clock
    input wire reset,           // Reset signal
    output reg h_sync,          // Horizontal sync
    output reg v_sync,          // Vertical sync
    output reg [2:0] rgb        // RGB output
);

    // Define custom horizontal and vertical limits
	     //localparam V_TOTAL        = V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH; 
		  //localparam H_TOTAL        = H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH; 
    localparam H_TOTAL = 10;  // **h_counter resets at 9**
    localparam V_TOTAL = 6;   // **v_counter resets at 5**

    reg [3:0] h_counter = 0;  // 4-bit counter (0 to 9)
    reg [2:0] v_counter = 0;  // 3-bit counter (0 to 5)

    // **Clock Divider for 25MHz Pixel Clock**
    reg pixel_clk;
    reg [1:0] clk_div = 0;
    
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
        pixel_clk <= clk_div[1]; // Divide 100MHz clock by 4 for 25MHz pixel clock
    end

    // **Horizontal and Vertical Counter Logic**
    always @(posedge pixel_clk or posedge reset) begin
        if (reset) begin
            h_counter <= 0;
            v_counter <= 0;
        end else begin
            if (h_counter < H_TOTAL - 1) begin
                h_counter <= h_counter + 1;
            end else begin
                h_counter <= 0;
                if (v_counter < V_TOTAL - 1) begin
                    v_counter <= v_counter + 1;
                end else begin
                    v_counter <= 0;
                end
            end
        end
    end

    // **Sync Signal Generation**
    always @(posedge pixel_clk) begin
        h_sync <= ~(h_counter >= 3 && h_counter < 7); // Example condition
        v_sync <= ~(v_counter >= 2 && v_counter < 4); // Example condition
    end

    // **RGB Output: Dynamic Color Pattern**
    always @(posedge pixel_clk) begin
        if (h_counter < H_TOTAL && v_counter < V_TOTAL) begin
            case ((h_counter[1] ^ v_counter[1]))
                1'b0: rgb <= 3'b100; // Red
                1'b1: rgb <= 3'b010; // Green
            endcase
        end else begin
            rgb <= 3'b000; // Black outside visible area
        end
    end

endmodule */
`timescale 1ns / 1ps

module vga_controller(
    input wire clk,             // 100MHz Clock
    input wire reset,           // Reset signal
    output reg h_sync,          // Horizontal sync
    output reg v_sync,          // Vertical sync
    output reg [2:0] rgb        // RGB output
);

    // Custom horizontal and vertical limits
    localparam H_TOTAL = 10;  // h_counter resets at 9
    localparam V_TOTAL = 6;   // v_counter resets at 5

    reg [3:0] h_counter = 0;  // 4-bit counter (0 to 9)
    reg [2:0] v_counter = 0;  // 3-bit counter (0 to 5)

    // **Clock Divider for 25MHz Pixel Clock**
    reg pixel_clk;
    reg [1:0] clk_div = 0;
    
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
        pixel_clk <= clk_div[1]; // Divide 100MHz clock by 4 for 25MHz pixel clock
    end

    // **Horizontal and Vertical Counter Logic**
    always @(posedge pixel_clk or posedge reset) begin
        if (reset) begin
            h_counter <= 0;
            v_counter <= 0;
        end else begin
            if (h_counter < H_TOTAL - 1) begin
                h_counter <= h_counter + 1;
            end else begin
                h_counter <= 0;
                if (v_counter < V_TOTAL - 1) begin
                    v_counter <= v_counter + 1;
                end else begin
                    v_counter <= 0;
                end
            end
        end
    end

    // **Sync Signal Generation - Adjusted Timing**
    always @(posedge pixel_clk) begin
        h_sync <= (h_counter >= 7);  // h_sync LOW only for h_counter [7,8,9]
        v_sync <= (v_counter >= 3);  // v_sync LOW only for v_counter [3,4,5]
    end

    // **RGB Output: Smooth Color Transition**
    always @(posedge pixel_clk) begin
        if (h_counter < H_TOTAL && v_counter < V_TOTAL) begin
            case ({h_counter[2], v_counter[2]})
                2'b00: rgb <= 3'b100; // Red
                2'b01: rgb <= 3'b010; // Green
                2'b10: rgb <= 3'b001; // Blue
                default: rgb <= 3'b111; // White
            endcase
        end else begin
            rgb <= 3'b000; // Black outside visible area
        end
    end

endmodule 