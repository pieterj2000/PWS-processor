library verilog;
use verilog.vl_types.all;
entity Tester is
    port(
        clock           : in     vl_logic;
        wen             : in     vl_logic;
        ren             : in     vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end Tester;
