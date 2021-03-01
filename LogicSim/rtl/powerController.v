module powerController (
    input wire sw_sig, por, ocp_trigger,
    output wire pwr_dis
);
    wire Nsw_sig, w1, q, Nq, s;

    nand u3a (pwr_dis, Nq, sw_sig);
    nand u3b (Nsw_sig, sw_sig, sw_sig);
    
    nor u4a (w1, ocp_trigger, por);
    nor u4b (s, w1, w1);
    nor u4c (q, Nsw_sig, Nq);
    nor u4d (Nq, s, q);

endmodule