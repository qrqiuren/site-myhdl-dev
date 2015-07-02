
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mdarray_access is
  generic ( w : integer := 2 );
  port (
    clock : in std_logic;
    data_i : in unsigned(7 downto 0);
    wr : in std_logic;
    col : in unsigned(w downto 0);  -- address in 1D array (column)
    row : in unsigned(w downto 0);  -- row selection in 2D array
    slc : in unsigned(w downto 0);  -- square slice in 3D array
    data_o : out unsigned(7 downto 0)
    );
end entity mdarray_access;

architecture beh of mdarray_access is

  type cube is array (w downto 0, w downto 0, w downto 0) of unsigned(7 downto 0);
  signal mdarray : cube;
  signal data_d : unsigned(7 downto 0);
begin
 
  process(clock)
    variable islc : integer;
    variable irow : integer;
    variable icol : integer;
  begin
    if (rising_edge(clock)) then
      islc := to_integer(slc);
      irow := to_integer(row);
      icol := to_integer(col);
      if (wr = '1') then
        mdarray(islc, irow, icol) <= data_i;
      end if;
      data_d <= mdarray(islc, irow, icol);
      data_o <= data_d;
    end if;   
  end process;  
  
end architecture beh; 
