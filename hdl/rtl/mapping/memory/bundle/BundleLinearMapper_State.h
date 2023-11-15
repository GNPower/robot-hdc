`ifndef BUNDLE_LINEAR_MAPPER_DEFINE_STATE
`define BUNDLE_LINEAR_MAPPER_DEFINE_STATE


typedef enum logic[2:0] {
	S_IDLE,
	S_MAPA_0,
	S_MAPB_0
} MapperBundleLinear_State_t;


`endif