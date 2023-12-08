`ifndef COSINE_SIMILARITY_DEFINE_STATE
`define COSINE_SIMILARITY_DEFINE_STATE


typedef enum logic[1:0] {
	S_IDLE,
	S_DATA_WAIT_0,
	S_DATA_WAIT_1,
	S_DATA_WAIT_2
} CosineSimilarity_State_t;


`endif