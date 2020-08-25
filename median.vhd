library ieee;
use ieee.std_logic_1164.all;
entity median is 
port ( input1 : in std_logic_vector( 7 downto 0);
          input2 : in std_logic_vector( 7 downto 0);
			 input3 : in std_logic_vector( 7 downto 0);
			 input4 : in std_logic_vector( 7 downto 0);
			 input5 : in std_logic_vector( 7 downto 0);
          clk : in std_logic;
			 reset : in std_logic ;
			 output : out std_logic_vector(7 downto 0) );
			 
			 end median;
			 
			 --------------------------------------------------------------------------------
			 --------------------------------------------------------------------------------
			 
			 
			 architecture median of median is 
    		 --------------------------
		    	 function compare  ( signal in1 , in2 : std_logic_vector)   return integer is   --returns which one is bigger 1 or 2
		
		   	 begin
			         for i in in1'range loop
			             if ( in1(i) > in2(i)) then
		            	 return 1;
		            	 elsif ( in2(i) > in1(i)) then
			             return 2;
		            	end if; 
		      	end loop; 
					return 1;  --if 1 and in2 are equal
			end  function compare; 
			   
				-----------------------
			 type mem is array (0 to 4) of std_logic_vector(7 downto 0);   --for 5  8bit numbers
			 signal	temp_array : mem :=( others => ( others => '0' )) ;
			 
			 
		begin
		
			process( clk, reset,input1,input2,input3,input4, input5)
		 		variable comp_num : integer := 0;
				variable temp: std_logic_vector(7 downto 0 );  --is needed for swaping
		       	
			begin 
			if (reset = '0'  and  rising_edge(clk)) then 
		temp_array(0) <= input1;
		temp_array(1) <= input2;
		temp_array(2) <= input3;
		temp_array(3) <= input4;
		temp_array(4) <= input5;
		
		
		
			for j in 0 to 4 loop    --maximum times that one array should be compared with next array
			for i in 0 to 3 loop    --becuase after 4 theres nothing to compare with
			comp_num:=compare( temp_array(i), temp_array(i+1));  --if its 1 nothing changes
			if ( comp_num = 2 ) then  --second one is bigger
			temp := temp_array(i);
			temp_array(i) <= temp_array(i+1);
			temp_array(i+1) <= temp;
			end if ;
			end loop;
	      end loop ;
				else
			 output <= "XXXXXXXX";
			end if;
			output <= temp_array(2); -- its median number  
			
			end process;
			end median;
			
			 
			 
			 
			 
			 
			 