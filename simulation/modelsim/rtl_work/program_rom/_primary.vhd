library verilog;
use verilog.vl_types.all;
entity program_rom is
    port(
        address         : in     vl_logic_vector(10 downto 0);
        clock           : in     vl_logic;
        q               : out    vl_logic_vector(39 downto 0)
    );
end program_rom;
