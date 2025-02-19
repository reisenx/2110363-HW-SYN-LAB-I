`timescale 1ns / 1ps

module skilltest1 (
    input  wire       Clk,
    input  wire       Reset,
    input  wire [3:0] Trigger,
    output wire [3:0] BCD0,
    output wire [3:0] BCD1,
    output wire [3:0] BCD2,
    output wire [3:0] BCD3
);

// Initialize variables
reg [15:0]  currentBCD      = 1;
reg [3:0]   currentBCD0     = 1;
reg [3:0]   currentBCD1     = 0;
reg [3:0]   currentBCD2     = 0;
reg [3:0]   currentBCD3     = 0;

reg [15:0]  counter         = 0;
reg [3:0]   prevTrigger     = 0;
reg         debounceEnable  = 1;
reg         overflow        = 0;

// Output assignment
assign BCD0 = currentBCD0;
assign BCD1 = currentBCD1;
assign BCD2 = currentBCD2;
assign BCD3 = currentBCD3;

// Debounce the signal by looping for 1024 clocks
always @(posedge Clk) begin
    // If the Reset button is pressed
    if(Reset) begin
        currentBCD      <= 1;
        currentBCD0     <= 1;
        currentBCD1     <= 0;
        currentBCD2     <= 0;
        currentBCD3     <= 0;

        counter         <= 0;
        prevTrigger     <= 0;
        debounceEnable  <= 1;
        overflow        <= 0;
    end

    // Store a new trigger value
    if(debounceEnable) begin
        if(Trigger != 0) begin
            prevTrigger     <= Trigger;
            debounceEnable  <= 0;
            counter         <= 1;
        end
    end
    else begin
        // If there's a new Trigger after 1024 clocks
        if(counter >= 1023) begin
            if(Trigger != prevTrigger) begin
                debounceEnable  <= 1;
                counter         <= 0;
            end
        end
        // Looping for 1024 clocks
        else begin
            counter <= counter + 1;
        end
    end
end

// Calculate current currentBCD
always @(posedge Clk) begin
    if(!overflow && counter == 1) begin
        case(prevTrigger)
            // Trigger[0] is 1: Increment by 1
            4'b0001: begin
                currentBCD <= currentBCD + 1;
                // Handles overflow
                if(currentBCD + 1 > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end

            // Trigger[1] is 1: Increment by 2
            4'b0010: begin
                currentBCD <= currentBCD + 2;
                // Handles overflow
                if(currentBCD + 2 > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end

            // Trigger[2] is 1: Multiply by 2
            4'b0100: begin
                currentBCD <= currentBCD * 2;
                // Handles overflow
                if(currentBCD * 2 > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end

            // Trigger[3] is 1: Multiply by 3
            4'b1000: begin
                currentBCD <= currentBCD * 3;
                // Handles overflow
                if(currentBCD * 3 > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end
        endcase
    end
end

// Extract digits from a currentBCD
always @(posedge Clk) begin
    if(!overflow) begin
        currentBCD0 <= currentBCD % 10;
        currentBCD1 <= (currentBCD / 10) % 10;
        currentBCD2 <= (currentBCD / 100) % 10;
        currentBCD3 <= currentBCD / 1000;
    end
end

endmodule