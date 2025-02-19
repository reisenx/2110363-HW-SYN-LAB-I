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

reg [15:0]  currentBCD  = 1;
reg [3:0]   currentBCD0 = 1;
reg [3:0]   currentBCD1 = 0;
reg [3:0]   currentBCD2 = 0;
reg [3:0]   currentBCD3 = 0;

reg [15:0]  counter = 0;
reg [3:0]   prevTrigger = 0;
reg         debounceEnable = 1;
reg         overflow = 0;

assign BCD0 = currentBCD0;
assign BCD1 = currentBCD1;
assign BCD2 = currentBCD2;
assign BCD3 = currentBCD3;

always @(posedge Clk) begin
    if(Reset) begin
        currentBCD  <= 1;
        currentBCD0 <= 1;
        currentBCD1 <= 0;
        currentBCD2 <= 0;
        currentBCD3 <= 0;

        counter         <= 1;
        prevTrigger     <= 0;
        debounceEnable  <= 1;
        overflow        <= 0;
    end

    if(debounceEnable) begin
        if(Trigger != 4'b0000) begin
            prevTrigger <= Trigger;
            debounceEnable <= 0;
            counter <= 1;
        end
    end
    else begin
        if(counter >= 1023) begin
            if(Trigger != prevTrigger) begin
                counter         <= 0;
                debounceEnable  <= 1;
            end
        end
        else begin
            counter <= counter + 1;
        end
    end
end

always @(posedge Clk) begin
    if(Reset) begin
        currentBCD  <= 1;
        currentBCD0 <= 1;
        currentBCD1 <= 0;
        currentBCD2 <= 0;
        currentBCD3 <= 0;

        counter         <= 1;
        prevTrigger     <= 0;
        debounceEnable  <= 1;
        overflow        <= 0;
    end
    else begin
        if(!overflow && counter == 1) begin
            if(prevTrigger == 4'b0001) begin
                currentBCD <= currentBCD + 1;
                if(currentBCD > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end

            if(prevTrigger == 4'b0010) begin
                currentBCD <= currentBCD + 2;
                if(currentBCD > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end

            if(prevTrigger == 4'b0100) begin
                currentBCD <= currentBCD * 2;
                if(currentBCD > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end

            if(prevTrigger == 4'b1000) begin
                currentBCD <= currentBCD * 11;
                if(currentBCD > 9999) begin
                    currentBCD0 <= 4'b1111;
                    currentBCD1 <= 4'b1111;
                    currentBCD2 <= 4'b1111;
                    currentBCD3 <= 4'b1111;
                    overflow <= 1;
                end
            end
        end
    end
end

always @(posedge Clk) begin
    if(!overflow) begin
        currentBCD0 <= currentBCD % 10;
        currentBCD1 <= (currentBCD / 10) % 10;
        currentBCD2 <= (currentBCD / 100) % 10;
        currentBCD3 <= currentBCD / 1000;
    end
end

endmodule