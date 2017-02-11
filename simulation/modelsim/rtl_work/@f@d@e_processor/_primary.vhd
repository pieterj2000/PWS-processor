library verilog;
use verilog.vl_types.all;
entity FDE_processor is
    port(
        pc              : out    vl_logic_vector(15 downto 0);
        clock           : out    vl_logic
    );
end FDE_processor;
