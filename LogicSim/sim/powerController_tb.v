module powerController_tb();

    reg sw, ocp_t, rst;
    wire pwr_disabled;

    powerController DUT (
        .sw_sig(sw),
        .ocp_trigger(ocp_t),
        .por(rst),
        .pwr_dis(pwr_disabled)
    );

    initial begin
        $monitor($time, ": %b %b %b | %b", sw, ocp_t, rst, pwr_disabled);
        $display($time, ": S O R | D");
        $display($time, ": ------+--");
    end

    initial begin
        sw      <= 1'b0;
        ocp_t   <= 1'b0;
        rst     <= 1'b1; // rst
        
        #10;
        sw      <= 1'b0;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // stable

        #10;
        sw      <= 1'b1;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // enable
        #10;
        sw      <= 1'b1;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // enable

        #10;
        sw      <= 1'b1;
        ocp_t   <= 1'b1;
        rst     <= 1'b0; // ocp triggered

        #10;
        sw      <= 1'b1;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // ocp gone because disabled

        #10;
        sw      <= 1'b1;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // sw still enable

        #10;
        sw      <= 1'b0;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // disable sw

        #20;
        sw      <= 1'b1;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // re-enable sw

        #10;
        sw      <= 1'b0;
        ocp_t   <= 1'b0;
        rst     <= 1'b0; // disable sw                          

        #10; $stop();

    end

endmodule