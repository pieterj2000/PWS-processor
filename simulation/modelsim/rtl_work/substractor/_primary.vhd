library verilog;
use verilog.vl_types.all;
entity substractor is
    port(
        output_byte     : out    vl_logic_vector(7 downto 0);
        co              : out    vl_logic;
        a1              : in     vl_logic_vector(7 downto 0);
        a2              : in     vl_logic_vector(7 downto 0);
        cinitial        : in     vl_logic
    );
end substractor;
