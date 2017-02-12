library verilog;
use verilog.vl_types.all;
entity FDE_processor is
    port(
        pc              : out    vl_logic_vector(15 downto 0);
        clock           : out    vl_logic;
        outputArgument  : in     vl_logic_vector(15 downto 0)
    );
end FDE_processor;
