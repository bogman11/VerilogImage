module main;
 
    reg clk, reset;
 
    wire [7:0] addressBus, memoryOutput;
  //  CPU processor(clk, reset, addressBus, memoryOutput);
 //   ROM memory(addressBus, memoryOutput);
 
	wire [7:0] in_pix, out_pix;
	wire [5:0] in_row, in_col, out_row, out_col;
	wire out_we;
 
	process proc(clk, 2'b0, in_pix, in_row, in_col, out_row, out_col, out_we, out_pix, done);
	image im(clk, in_row, in_col, out_we, out_pix, in_pix);
 
    integer currentTime;
    localparam DELAY=20;
 
    always
	begin
		#(DELAY/2) clk = ~clk;
		#(DELAY/2) clk = ~clk;
		
		currentTime = currentTime + 1;
		$display("\n-------------------------------------------------------------Tick %d-------------------------------------------------------------", currentTime);
	end

	initial
	begin
		currentTime = 1;
		reset = 0;
		clk = 0;
		
		#100; //wait for global reset to finish
		
		$display("-------------------------------------------------------------Tick %d-------------------------------------------------------------", currentTime);
		#(2.5 * DELAY) reset = 1;
		#(DELAY*2) reset = 0;
		 		
	end 
      
endmodule