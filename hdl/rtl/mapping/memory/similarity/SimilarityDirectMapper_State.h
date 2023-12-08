`ifndef BIND_DIRECT_MAPPER_DEFINE_STATE
`define BIND_DIRECT_MAPPER_DEFINE_STATE


typedef enum logic[2:0] {
	S_IDLE,
	S_MAPA_0,
	S_MAPA_1,
	S_MAPA_2,
	S_MAPA_3,
	S_MAPA_4,
	S_DATA_WAIT_0
} MapperSimilarityDirect_State_t;


`endif