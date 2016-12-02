library verilog;
use verilog.vl_types.all;
entity bitsubber is
    port(
        \out\           : out    vl_logic;
        co              : out    vl_logic;
        a1              : in     vl_logic;
        a2              : in     vl_logic;
        c1              : in     vl_logic
    );
end bitsubber;
