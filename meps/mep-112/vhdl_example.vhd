
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mdarray_access is
  port (
    clock : in std_logic;
    reset : in std_logic;
    data_i : in unsigned(31 downto 0);
    wr : in std_logic;
    col : in unsigned(1 downto 0);  -- address in 1D array (column)
    row : in unsigned(1 downto 0);  -- row selection in 2D array
    slc : in unsigned(1 downto 0);  -- square slice in 3D array
    data_o : out unsigned(31 downto 0)
    );
end entity mdarray_access;

architecture beh of mdarray_access is

  type cube is array (3 downto 0, 3 downto 0, 3 downto 0) of unsigned(31 downto 0);
  signal mdarray : cube;  
begin
 
  process(clock, reset)
    variable islc : integer;
    variable irow : integer;
    variable icol : integer;
  begin
    if (reset = '1') then
      mdarray <= (others => (others => (others => (others => '0'))));
    elsif (rising_edge(clock)) then
      islc := to_integer(slc);
      irow := to_integer(row);
      icol := to_integer(col);
      if (wr = '1') then
        mdarray(islc, irow, icol) <= data_i;
      else
        data_o <= mdarray(islc, irow, icol);
      end if; 
    end if;   
  end process;  
  
end architecture beh; 
