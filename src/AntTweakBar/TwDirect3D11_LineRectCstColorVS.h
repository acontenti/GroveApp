#if 0
//
// Generated by Microsoft (R) D3D Shader Disassembler
//
//
///
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// POSITION                 0   xyzw        0     NONE   float   xyzw
// COLOR                    0   xyzw        1     NONE   float       
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float   xyzw
// COLOR                    0   xyzw        1     NONE   float   xyzw
//
//
// Constant buffer to DX9 shader constant mappings:
//
// Target Reg Buffer  Start Reg # of Regs        Data Conversion
// ---------- ------- --------- --------- ----------------------
// c1         cb0             0         2  ( FLT, FLT, FLT, FLT)
//
//
// Runtime generated constant mappings:
//
// Target Reg                               Constant Description
// ---------- --------------------------------------------------
// c0                              Vertex Shader position offset
//
//
// Level9 shader bytecode:
//
    vs_2_0
    dcl_texcoord v0
    add r0, v0, c1
    mad oPos.xy, r0.w, c0, r0
    mov oPos.zw, r0
    mov oT0, c2

// approximately 4 instruction slots used
vs_4_0
dcl_constantbuffer cb0[2], immediateIndexed
dcl_input v0.xyzw
dcl_output_siv o0.xyzw, position
dcl_output o1.xyzw
add o0.xyzw, v0.xyzw, cb0[0].xyzw
mov o1.xyzw, cb0[1].xyzw
ret 
// Approximately 0 instruction slots used
#endif

const BYTE g_LineRectCstColorVS[] =
{
     68,  88,  66,  67, 198, 198, 
    206,  85, 131,  21, 226, 170, 
    219, 206,  68, 115,  57, 140, 
    191,  36,   1,   0,   0,   0, 
    228,   1,   0,   0,   4,   0, 
      0,   0,  48,   0,   0,   0, 
    188,   0,   0,   0,  64,   1, 
      0,   0, 144,   1,   0,   0, 
     65, 111, 110,  57, 132,   0, 
      0,   0, 132,   0,   0,   0, 
      0,   2, 254, 255,  80,   0, 
      0,   0,  52,   0,   0,   0, 
      1,   0,  36,   0,   0,   0, 
     48,   0,   0,   0,  48,   0, 
      0,   0,  36,   0,   1,   0, 
     48,   0,   0,   0,   0,   0, 
      2,   0,   1,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   2, 254, 255,  31,   0, 
      0,   2,   5,   0,   0, 128, 
      0,   0,  15, 144,   2,   0, 
      0,   3,   0,   0,  15, 128, 
      0,   0, 228, 144,   1,   0, 
    228, 160,   4,   0,   0,   4, 
      0,   0,   3, 192,   0,   0, 
    255, 128,   0,   0, 228, 160, 
      0,   0, 228, 128,   1,   0, 
      0,   2,   0,   0,  12, 192, 
      0,   0, 228, 128,   1,   0, 
      0,   2,   0,   0,  15, 224, 
      2,   0, 228, 160, 255, 255, 
      0,   0,  83,  72,  68,  82, 
    124,   0,   0,   0,  64,   0, 
      1,   0,  31,   0,   0,   0, 
     89,   0,   0,   4,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      2,   0,   0,   0,  95,   0, 
      0,   3, 242,  16,  16,   0, 
      0,   0,   0,   0, 103,   0, 
      0,   4, 242,  32,  16,   0, 
      0,   0,   0,   0,   1,   0, 
      0,   0, 101,   0,   0,   3, 
    242,  32,  16,   0,   1,   0, 
      0,   0,   0,   0,   0,   8, 
    242,  32,  16,   0,   0,   0, 
      0,   0,  70,  30,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,  54,   0, 
      0,   6, 242,  32,  16,   0, 
      1,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      1,   0,   0,   0,  62,   0, 
      0,   1,  73,  83,  71,  78, 
     72,   0,   0,   0,   2,   0, 
      0,   0,   8,   0,   0,   0, 
     56,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   0,   0, 
      0,   0,  15,  15,   0,   0, 
     65,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   1,   0, 
      0,   0,  15,   0,   0,   0, 
     80,  79,  83,  73,  84,  73, 
     79,  78,   0,  67,  79,  76, 
     79,  82,   0, 171,  79,  83, 
     71,  78,  76,   0,   0,   0, 
      2,   0,   0,   0,   8,   0, 
      0,   0,  56,   0,   0,   0, 
      0,   0,   0,   0,   1,   0, 
      0,   0,   3,   0,   0,   0, 
      0,   0,   0,   0,  15,   0, 
      0,   0,  68,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   3,   0,   0,   0, 
      1,   0,   0,   0,  15,   0, 
      0,   0,  83,  86,  95,  80, 
     79,  83,  73,  84,  73,  79, 
     78,   0,  67,  79,  76,  79, 
     82,   0, 171, 171
};
