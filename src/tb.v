`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

module tb (
    // testbench is controlled by test.py
    input clk,
    input rst,
    input i_data_clk,
    input [7:0] i_value,
    input [7:0] i_select,
    output [7:0] fw_out,
    output o_active
   );

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    wire [18:0] inputs = {i_select[7:0],i_value[7:0],i_data_clk, rst, clk};
    wire [8:0] outputs;
    assign fw_out[7:0] = outputs[7:0];
    assign o_active = outputs[8];

    // instantiate the DUT
    opensource_fr_fuzzy_wavelet osfr_fw (
        .io_in  (inputs),
        .io_out (outputs)
        );

endmodule
