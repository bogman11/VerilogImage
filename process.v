`timescale 1ns / 1ps

module process(
	input clk,						// clock 
	input [1:0] op,					// 0 - filtrul de tip blur; 1 - oglindire; 2 - rotire
	input [7:0] in_pix,				// valaorea pixelului de pe pozitia [in_row, in_col] din imaginea de intrare
	output reg [5:0] in_row, in_col, 	// selecteaza un rand si o coloana din imaginea de intrare 
	output reg [5:0] out_row, out_col,  // selecteaza un rand si o coloana din imaginea de iesire
	output reg out_we,					// activeaza scrierea pentru imaginea de iesire (write enable)
	output reg [7:0] out_pix,			// valoarea pixelului care va fi scrisa in imaginea de iesire pe pozitia [out_row, out_col]
	output reg done						// semnaleaza cand s-a terminat procesarea unei imagini
	);	

reg [31:0] state, next_state = 0;
reg [5:0] i,j;
reg [7:0] pix,pix_r,pix_t,pix_b,pix_l; //pixel central,pixel dreapta,pixel deasupra,pixel dedesubt,pixel stanga
`define state0          0
`define state1          1
`define state2				2
`define state3				3
`define state4				4
`define state5				5
`define state6          6

always@(posedge clk) begin
 
 
	case(op) 
		0: begin	
		case(state)
		`state0:begin 
			i=0;
			j=0;
			done = 0;
		end
		
		`state1:begin
		   
			in_row = i;
			in_col = j;
			pix = in_pix;
			
			if( i-1 >=0 ) begin 
					next_state = `state2;
					
			end else if( j+1 <= 63 ) begin 
								next_state = `state3;
								
			end else if ( i+1 <= 63 ) begin 
								next_state = `state4;
								
			end else if ( j-1 >= 0 ) begin
								next_state = `state5;
								
			end
			end
			
		 `state2:begin
			in_row = i-1;
			in_col = j;
			pix_t = in_pix;
			
			if( j+1 <= 63 ) begin 
								next_state = `state3;
								
			end else if ( i+1 <= 63 ) begin 
								next_state = `state4;
								
			end else if ( j-1 >= 0 ) begin
								next_state = `state5;
								
			end
			
			
		 end
		 
		 `state3:begin
			in_row = i;
			in_col = j+1;
			pix_r = in_pix;
			
			if ( i+1 <= 63 ) begin 
								next_state = `state4;
								
			end else if ( j-1 >= 0 ) begin
								next_state = `state5;
								
			end
			
			out_we = 1;
			out_row = i;
			out_col = j;
			out_pix = ( pix + pix_r + pix_t ) / 5;
			
			next_state = `state6;
		 end
			
		 `state4:begin
			in_row = i+1;
			in_col = j;
			pix_b = in_pix;
			
			if ( j-1 >= 0 ) begin
								next_state = `state5;
			end
			
			out_we = 1;
			out_row = i;
			out_col = j;
			out_pix = ( pix + pix_r + pix_t + pix_b ) / 5;
			
			next_state = `state6;
			
			end
			
		 `state5:begin
			in_row = i;
			in_col = j-1;
			pix_l= in_pix;
			
			out_we = 1;
			out_row = i;
			out_col = j;
			out_pix = ( pix + pix_r + pix_t + pix_b + pix_l ) / 5;
			
			next_state = `state6;
			
			end
			
		 `state6:begin 
		 
				if( j== 63 && i == 63) begin 
				 done = 1;
					end	
					else begin 
					 if(j == 63 ) begin   j = 0;
												 i = i + 1;
									  next_state = `state1;
									  end
							  else begin    j = j + 1;	 
									  next_state = `state1;
									  end
							end
			end	
			
			
endcase
end
endcase
end
endmodule
