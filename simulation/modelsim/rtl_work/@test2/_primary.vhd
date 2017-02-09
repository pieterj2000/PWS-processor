library verilog;
use verilog.vl_types.all;
entity Test2 is
    port(
        clock           : out    vl_logic;
        wen             : out    vl_logic;
        ren             : out    vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end Test2;
