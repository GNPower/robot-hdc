`ifndef BIND_KERNEL_MAPPER_DEFINE_STATE
`define BIND_KERNEL_MAPPER_DEFINE_STATE


typedef enum logic[2:0] {
	S_IDLE,
	S_MAP_0,
	S_MAP_1,
	S_MAP_2,
	S_MAP_3,
	S_MAP_4,
	S_MAP_5
} MapperBindKernel_State_t;


`endif