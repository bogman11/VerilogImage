`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       UPB
// Engineer:      Dan Dragomir
//
// Create Date:   11:23:41 11/22/2013
// Design Name:   tester tema2
// Module Name:   image
// Project Name:  tema2
// Target Device: ISim
// Tool versions: 14.6
// Description:   tester for homework 2: image processing
//
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module image(
		clk,
		row,
		col,
		we,
		in,
		out
    );

parameter init = 1;

input       clk;
input [5:0] row;
input [5:0] col;
input       we;
input [7:0] in;
output[7:0] out;

reg [7:0]   data[63:0][63:0];

integer data_file, i, j;
initial begin
    if(init) begin
        data_file = $fopen("test.data", "r");
        if(!data_file) begin
            $write("error opening data file\n");
            $finish;
        end
        for(i = 0; i < 64; i = i + 1) begin
            for(j = 0; j < 64; j = j + 1) begin
                if($fscanf(data_file, "%d\n", data[i][j]) != 1) begin
                    $write("error reading test data\n");
                    $finish;
                end
            end
        end
        $fclose(data_file);
    end
end

assign out = data[row][col];

always @(posedge clk) begin
	if(we)
		data[row][col] <= in;
end

endmodule
