
module TX_fsm(tx_start, clk, rst, shift, load,sel);
  input tx_start, clk, rst;
  output shift, load;
  output [1:0] sel;
  
  reg [2:0] state;
  reg [2:0] nextstate;
  reg temp, count, count1,flag, x;
  
  parameter idle = 3'b000, startbit = 3'b001, databit = 3'b010, paritybit = 3'b011, stopbit = 3'b100;
  
  always @(*)
    begin
      case(state)
        idle: 
          begin
            nextstate = tx_start?startbit:idle;
            load = 0;
            shift = 0;
            sel = 2'b11;
            temp = 0;
            
          end
        startbit: 
          begin
            nextstate = flag?databit:startbit;
            load = 1;
            shift = 0;
            sel = 2'b00;
            temp = 0;
            
          end
        databit:
          begin
            nextstate = x? paritybit:databit;
            load = 0;
            shift = 1;
            sel = 2'b01;
            temp = 1;
          end
        paritybit:
          begin
            nextstate = flag?stopbit:paritybit;
            load = 0;
            shift = 0;
            temp = 0;
            sel = 2'b10;
          end
        stopbit:
          begin
            nextstate = flag?idle:stopbit;
            load = 0;
            shift = 0;
            sel = 2'b11;
            temp = 0;
          end
        default:
          begin
            nextstate = idle;
            load = 0;
            shift = 0;
            sel = 2'b00;
            temp = 0;
          end
      endcase     
    end
  
  
  always @(posedge clk)
    begin
      if(count == 15)
        begin
          flag = 1;
          count = 0;
        end
      else
        begin
          flag = 0;
          count = count + 1;
        end
    end
  
  always @(posedge clk)
    begin
      if(temp == 1)
        if(count1 == 7)
          begin
            x = 1;
          end
      	else
          begin
            x = 0;
            count1 = count1 + 1;
          end
      else 
        begin
          count1 = 0;
          x = 0;
        end
    end
  
  always @(posedge clk)
    begin
      if(rst)
        begin
          state <= idle;
        end
      else
        state <= nextstate;
    end
endmodule
      
      
          
  
              
  
