`ifndef ELEMENT_ADDITION_CUT_BIPOLAR_DEFINE_STATE
`define ELEMENT_ADDITION_CUT_BIPOLAR_DEFINE_STATE


typedef enum logic[2:0] {
	S_IDLE,
	S_DATA_WAIT_0,
	S_FPADD_0,
	S_FPADD_1,
	S_FPADD_2,
	S_COMP,
	S_DATA_RDY
} ElemAdd_State_t;


`endif