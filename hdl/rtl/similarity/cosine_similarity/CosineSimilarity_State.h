`ifndef COSINE_SIMILARITY_DEFINE_STATE
`define COSINE_SIMILARITY_DEFINE_STATE


typedef enum logic[4:0] {
	S_IDLE,
	S_DATA_WAIT_0,
	S_DATA_WAIT_1,
	S_MAC_0,
	S_MAC_1,
	S_MAC_2,
	S_MAC_3,
	S_MAC_4,
	S_MAC_5,
	S_MAC_6,
	S_MAC_7,
	S_MAC_8,
	S_SIM_0,
	S_SIM_1,
	S_SIM_2,
	S_SIM_3,
	S_SIM_4,
	S_SIM_5,
	S_SIM_6
} CosineSimilarity_State_t;


`endif