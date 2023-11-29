`ifndef BIND_DIRECT_MAPPER_DEFINE_STATE
`define BIND_DIRECT_MAPPER_DEFINE_STATE


typedef enum logic[3:0] {
	S_IDLE,
	S_MAPB_0,
	S_MAPB_1,
	S_MAPB_2,
	S_MAPB_3,
	S_WRITE_0
} MapperBindDirect_State_t;


`endif