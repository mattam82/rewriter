static void fesquare(uint32_t out[16], const uint32_t in1[16]) {
  { const uint32_t x29 = in1[15];
  { const uint32_t x30 = in1[14];
  { const uint32_t x28 = in1[13];
  { const uint32_t x26 = in1[12];
  { const uint32_t x24 = in1[11];
  { const uint32_t x22 = in1[10];
  { const uint32_t x20 = in1[9];
  { const uint32_t x18 = in1[8];
  { const uint32_t x16 = in1[7];
  { const uint32_t x14 = in1[6];
  { const uint32_t x12 = in1[5];
  { const uint32_t x10 = in1[4];
  { const uint32_t x8 = in1[3];
  { const uint32_t x6 = in1[2];
  { const uint32_t x4 = in1[1];
  { const uint32_t x2 = in1[0];
  { uint64_t x31 = (((uint64_t)(x16 + x29) * (x16 + x29)) - ((uint64_t)x16 * x16));
  { uint64_t x32 = ((((uint64_t)(x14 + x30) * (x16 + x29)) + ((uint64_t)(x16 + x29) * (x14 + x30))) - (((uint64_t)x14 * x16) + ((uint64_t)x16 * x14)));
  { uint64_t x33 = ((((uint64_t)(x12 + x28) * (x16 + x29)) + (((uint64_t)(x14 + x30) * (x14 + x30)) + ((uint64_t)(x16 + x29) * (x12 + x28)))) - (((uint64_t)x12 * x16) + (((uint64_t)x14 * x14) + ((uint64_t)x16 * x12))));
  { uint64_t x34 = ((((uint64_t)(x10 + x26) * (x16 + x29)) + (((uint64_t)(x12 + x28) * (x14 + x30)) + (((uint64_t)(x14 + x30) * (x12 + x28)) + ((uint64_t)(x16 + x29) * (x10 + x26))))) - (((uint64_t)x10 * x16) + (((uint64_t)x12 * x14) + (((uint64_t)x14 * x12) + ((uint64_t)x16 * x10)))));
  { uint64_t x35 = ((((uint64_t)(x8 + x24) * (x16 + x29)) + (((uint64_t)(x10 + x26) * (x14 + x30)) + (((uint64_t)(x12 + x28) * (x12 + x28)) + (((uint64_t)(x14 + x30) * (x10 + x26)) + ((uint64_t)(x16 + x29) * (x8 + x24)))))) - (((uint64_t)x8 * x16) + (((uint64_t)x10 * x14) + (((uint64_t)x12 * x12) + (((uint64_t)x14 * x10) + ((uint64_t)x16 * x8))))));
  { uint64_t x36 = ((((uint64_t)(x6 + x22) * (x16 + x29)) + (((uint64_t)(x8 + x24) * (x14 + x30)) + (((uint64_t)(x10 + x26) * (x12 + x28)) + (((uint64_t)(x12 + x28) * (x10 + x26)) + (((uint64_t)(x14 + x30) * (x8 + x24)) + ((uint64_t)(x16 + x29) * (x6 + x22))))))) - (((uint64_t)x6 * x16) + (((uint64_t)x8 * x14) + (((uint64_t)x10 * x12) + (((uint64_t)x12 * x10) + (((uint64_t)x14 * x8) + ((uint64_t)x16 * x6)))))));
  { uint64_t x37 = ((((uint64_t)(x4 + x20) * (x16 + x29)) + (((uint64_t)(x6 + x22) * (x14 + x30)) + (((uint64_t)(x8 + x24) * (x12 + x28)) + (((uint64_t)(x10 + x26) * (x10 + x26)) + (((uint64_t)(x12 + x28) * (x8 + x24)) + (((uint64_t)(x14 + x30) * (x6 + x22)) + ((uint64_t)(x16 + x29) * (x4 + x20)))))))) - (((uint64_t)x4 * x16) + (((uint64_t)x6 * x14) + (((uint64_t)x8 * x12) + (((uint64_t)x10 * x10) + (((uint64_t)x12 * x8) + (((uint64_t)x14 * x6) + ((uint64_t)x16 * x4))))))));
  { uint64_t x38 = ((((uint64_t)(x2 + x18) * (x16 + x29)) + (((uint64_t)(x4 + x20) * (x14 + x30)) + (((uint64_t)(x6 + x22) * (x12 + x28)) + (((uint64_t)(x8 + x24) * (x10 + x26)) + (((uint64_t)(x10 + x26) * (x8 + x24)) + (((uint64_t)(x12 + x28) * (x6 + x22)) + (((uint64_t)(x14 + x30) * (x4 + x20)) + ((uint64_t)(x16 + x29) * (x2 + x18))))))))) - (((uint64_t)x2 * x16) + (((uint64_t)x4 * x14) + (((uint64_t)x6 * x12) + (((uint64_t)x8 * x10) + (((uint64_t)x10 * x8) + (((uint64_t)x12 * x6) + (((uint64_t)x14 * x4) + ((uint64_t)x16 * x2)))))))));
  { uint64_t x39 = ((((uint64_t)(x2 + x18) * (x14 + x30)) + (((uint64_t)(x4 + x20) * (x12 + x28)) + (((uint64_t)(x6 + x22) * (x10 + x26)) + (((uint64_t)(x8 + x24) * (x8 + x24)) + (((uint64_t)(x10 + x26) * (x6 + x22)) + (((uint64_t)(x12 + x28) * (x4 + x20)) + ((uint64_t)(x14 + x30) * (x2 + x18)))))))) - (((uint64_t)x2 * x14) + (((uint64_t)x4 * x12) + (((uint64_t)x6 * x10) + (((uint64_t)x8 * x8) + (((uint64_t)x10 * x6) + (((uint64_t)x12 * x4) + ((uint64_t)x14 * x2))))))));
  { uint64_t x40 = ((((uint64_t)(x2 + x18) * (x12 + x28)) + (((uint64_t)(x4 + x20) * (x10 + x26)) + (((uint64_t)(x6 + x22) * (x8 + x24)) + (((uint64_t)(x8 + x24) * (x6 + x22)) + (((uint64_t)(x10 + x26) * (x4 + x20)) + ((uint64_t)(x12 + x28) * (x2 + x18))))))) - (((uint64_t)x2 * x12) + (((uint64_t)x4 * x10) + (((uint64_t)x6 * x8) + (((uint64_t)x8 * x6) + (((uint64_t)x10 * x4) + ((uint64_t)x12 * x2)))))));
  { uint64_t x41 = ((((uint64_t)(x2 + x18) * (x10 + x26)) + (((uint64_t)(x4 + x20) * (x8 + x24)) + (((uint64_t)(x6 + x22) * (x6 + x22)) + (((uint64_t)(x8 + x24) * (x4 + x20)) + ((uint64_t)(x10 + x26) * (x2 + x18)))))) - (((uint64_t)x2 * x10) + (((uint64_t)x4 * x8) + (((uint64_t)x6 * x6) + (((uint64_t)x8 * x4) + ((uint64_t)x10 * x2))))));
  { uint64_t x42 = ((((uint64_t)(x2 + x18) * (x8 + x24)) + (((uint64_t)(x4 + x20) * (x6 + x22)) + (((uint64_t)(x6 + x22) * (x4 + x20)) + ((uint64_t)(x8 + x24) * (x2 + x18))))) - (((uint64_t)x2 * x8) + (((uint64_t)x4 * x6) + (((uint64_t)x6 * x4) + ((uint64_t)x8 * x2)))));
  { uint64_t x43 = ((((uint64_t)(x2 + x18) * (x6 + x22)) + (((uint64_t)(x4 + x20) * (x4 + x20)) + ((uint64_t)(x6 + x22) * (x2 + x18)))) - (((uint64_t)x2 * x6) + (((uint64_t)x4 * x4) + ((uint64_t)x6 * x2))));
  { uint64_t x44 = ((((uint64_t)(x2 + x18) * (x4 + x20)) + ((uint64_t)(x4 + x20) * (x2 + x18))) - (((uint64_t)x2 * x4) + ((uint64_t)x4 * x2)));
  { uint64_t x45 = (((uint64_t)(x2 + x18) * (x2 + x18)) - ((uint64_t)x2 * x2));
  { uint64_t x46 = (((((uint64_t)x16 * x16) + ((uint64_t)x29 * x29)) + x39) + x31);
  { uint64_t x47 = ((((((uint64_t)x14 * x16) + ((uint64_t)x16 * x14)) + (((uint64_t)x30 * x29) + ((uint64_t)x29 * x30))) + x40) + x32);
  { uint64_t x48 = ((((((uint64_t)x12 * x16) + (((uint64_t)x14 * x14) + ((uint64_t)x16 * x12))) + (((uint64_t)x28 * x29) + (((uint64_t)x30 * x30) + ((uint64_t)x29 * x28)))) + x41) + x33);
  { uint64_t x49 = ((((((uint64_t)x10 * x16) + (((uint64_t)x12 * x14) + (((uint64_t)x14 * x12) + ((uint64_t)x16 * x10)))) + (((uint64_t)x26 * x29) + (((uint64_t)x28 * x30) + (((uint64_t)x30 * x28) + ((uint64_t)x29 * x26))))) + x42) + x34);
  { uint64_t x50 = ((((((uint64_t)x8 * x16) + (((uint64_t)x10 * x14) + (((uint64_t)x12 * x12) + (((uint64_t)x14 * x10) + ((uint64_t)x16 * x8))))) + (((uint64_t)x24 * x29) + (((uint64_t)x26 * x30) + (((uint64_t)x28 * x28) + (((uint64_t)x30 * x26) + ((uint64_t)x29 * x24)))))) + x43) + x35);
  { uint64_t x51 = ((((((uint64_t)x6 * x16) + (((uint64_t)x8 * x14) + (((uint64_t)x10 * x12) + (((uint64_t)x12 * x10) + (((uint64_t)x14 * x8) + ((uint64_t)x16 * x6)))))) + (((uint64_t)x22 * x29) + (((uint64_t)x24 * x30) + (((uint64_t)x26 * x28) + (((uint64_t)x28 * x26) + (((uint64_t)x30 * x24) + ((uint64_t)x29 * x22))))))) + x44) + x36);
  { uint64_t x52 = ((((((uint64_t)x4 * x16) + (((uint64_t)x6 * x14) + (((uint64_t)x8 * x12) + (((uint64_t)x10 * x10) + (((uint64_t)x12 * x8) + (((uint64_t)x14 * x6) + ((uint64_t)x16 * x4))))))) + (((uint64_t)x20 * x29) + (((uint64_t)x22 * x30) + (((uint64_t)x24 * x28) + (((uint64_t)x26 * x26) + (((uint64_t)x28 * x24) + (((uint64_t)x30 * x22) + ((uint64_t)x29 * x20)))))))) + x45) + x37);
  { uint64_t x53 = ((((uint64_t)x2 * x16) + (((uint64_t)x4 * x14) + (((uint64_t)x6 * x12) + (((uint64_t)x8 * x10) + (((uint64_t)x10 * x8) + (((uint64_t)x12 * x6) + (((uint64_t)x14 * x4) + ((uint64_t)x16 * x2)))))))) + (((uint64_t)x18 * x29) + (((uint64_t)x20 * x30) + (((uint64_t)x22 * x28) + (((uint64_t)x24 * x26) + (((uint64_t)x26 * x24) + (((uint64_t)x28 * x22) + (((uint64_t)x30 * x20) + ((uint64_t)x29 * x18)))))))));
  { uint64_t x54 = (((((uint64_t)x2 * x14) + (((uint64_t)x4 * x12) + (((uint64_t)x6 * x10) + (((uint64_t)x8 * x8) + (((uint64_t)x10 * x6) + (((uint64_t)x12 * x4) + ((uint64_t)x14 * x2))))))) + (((uint64_t)x18 * x30) + (((uint64_t)x20 * x28) + (((uint64_t)x22 * x26) + (((uint64_t)x24 * x24) + (((uint64_t)x26 * x22) + (((uint64_t)x28 * x20) + ((uint64_t)x30 * x18)))))))) + x31);
  { uint64_t x55 = (((((uint64_t)x2 * x12) + (((uint64_t)x4 * x10) + (((uint64_t)x6 * x8) + (((uint64_t)x8 * x6) + (((uint64_t)x10 * x4) + ((uint64_t)x12 * x2)))))) + (((uint64_t)x18 * x28) + (((uint64_t)x20 * x26) + (((uint64_t)x22 * x24) + (((uint64_t)x24 * x22) + (((uint64_t)x26 * x20) + ((uint64_t)x28 * x18))))))) + x32);
  { uint64_t x56 = (((((uint64_t)x2 * x10) + (((uint64_t)x4 * x8) + (((uint64_t)x6 * x6) + (((uint64_t)x8 * x4) + ((uint64_t)x10 * x2))))) + (((uint64_t)x18 * x26) + (((uint64_t)x20 * x24) + (((uint64_t)x22 * x22) + (((uint64_t)x24 * x20) + ((uint64_t)x26 * x18)))))) + x33);
  { uint64_t x57 = (((((uint64_t)x2 * x8) + (((uint64_t)x4 * x6) + (((uint64_t)x6 * x4) + ((uint64_t)x8 * x2)))) + (((uint64_t)x18 * x24) + (((uint64_t)x20 * x22) + (((uint64_t)x22 * x20) + ((uint64_t)x24 * x18))))) + x34);
  { uint64_t x58 = (((((uint64_t)x2 * x6) + (((uint64_t)x4 * x4) + ((uint64_t)x6 * x2))) + (((uint64_t)x18 * x22) + (((uint64_t)x20 * x20) + ((uint64_t)x22 * x18)))) + x35);
  { uint64_t x59 = (((((uint64_t)x2 * x4) + ((uint64_t)x4 * x2)) + (((uint64_t)x18 * x20) + ((uint64_t)x20 * x18))) + x36);
  { uint64_t x60 = ((((uint64_t)x2 * x2) + ((uint64_t)x18 * x18)) + x37);
  { uint64_t x61 = (x53 >> 0x1a);
  { uint32_t x62 = ((uint32_t)x53 & 0x3ffffff);
  { uint64_t x63 = (x38 >> 0x1a);
  { uint32_t x64 = ((uint32_t)x38 & 0x3ffffff);
  { uint64_t x65 = ((0x4000000 * x63) + x64);
  { uint64_t x66 = (x65 >> 0x1a);
  { uint32_t x67 = ((uint32_t)x65 & 0x3ffffff);
  { uint64_t x68 = ((x61 + x52) + x66);
  { uint64_t x69 = (x68 >> 0x1a);
  { uint32_t x70 = ((uint32_t)x68 & 0x3ffffff);
  { uint64_t x71 = (x60 + x66);
  { uint64_t x72 = (x71 >> 0x1a);
  { uint32_t x73 = ((uint32_t)x71 & 0x3ffffff);
  { uint64_t x74 = (x69 + x51);
  { uint64_t x75 = (x74 >> 0x1a);
  { uint32_t x76 = ((uint32_t)x74 & 0x3ffffff);
  { uint64_t x77 = (x72 + x59);
  { uint64_t x78 = (x77 >> 0x1a);
  { uint32_t x79 = ((uint32_t)x77 & 0x3ffffff);
  { uint64_t x80 = (x75 + x50);
  { uint64_t x81 = (x80 >> 0x1a);
  { uint32_t x82 = ((uint32_t)x80 & 0x3ffffff);
  { uint64_t x83 = (x78 + x58);
  { uint64_t x84 = (x83 >> 0x1a);
  { uint32_t x85 = ((uint32_t)x83 & 0x3ffffff);
  { uint64_t x86 = (x81 + x49);
  { uint64_t x87 = (x86 >> 0x1a);
  { uint32_t x88 = ((uint32_t)x86 & 0x3ffffff);
  { uint64_t x89 = (x84 + x57);
  { uint64_t x90 = (x89 >> 0x1a);
  { uint32_t x91 = ((uint32_t)x89 & 0x3ffffff);
  { uint64_t x92 = (x87 + x48);
  { uint64_t x93 = (x92 >> 0x1a);
  { uint32_t x94 = ((uint32_t)x92 & 0x3ffffff);
  { uint64_t x95 = (x90 + x56);
  { uint64_t x96 = (x95 >> 0x1a);
  { uint32_t x97 = ((uint32_t)x95 & 0x3ffffff);
  { uint64_t x98 = (x93 + x47);
  { uint64_t x99 = (x98 >> 0x1a);
  { uint32_t x100 = ((uint32_t)x98 & 0x3ffffff);
  { uint64_t x101 = (x96 + x55);
  { uint64_t x102 = (x101 >> 0x1a);
  { uint32_t x103 = ((uint32_t)x101 & 0x3ffffff);
  { uint64_t x104 = (x99 + x46);
  { uint64_t x105 = (x104 >> 0x1a);
  { uint32_t x106 = ((uint32_t)x104 & 0x3ffffff);
  { uint64_t x107 = (x102 + x54);
  { uint64_t x108 = (x107 >> 0x1a);
  { uint32_t x109 = ((uint32_t)x107 & 0x3ffffff);
  { uint64_t x110 = (x105 + x67);
  { uint32_t x111 = (uint32_t) (x110 >> 0x1a);
  { uint32_t x112 = ((uint32_t)x110 & 0x3ffffff);
  { uint64_t x113 = (x108 + x62);
  { uint32_t x114 = (uint32_t) (x113 >> 0x1a);
  { uint32_t x115 = ((uint32_t)x113 & 0x3ffffff);
  { uint64_t x116 = (((uint64_t)0x4000000 * x111) + x112);
  { uint32_t x117 = (uint32_t) (x116 >> 0x1a);
  { uint32_t x118 = ((uint32_t)x116 & 0x3ffffff);
  { uint32_t x119 = ((x114 + x70) + x117);
  { uint32_t x120 = (x119 >> 0x1a);
  { uint32_t x121 = (x119 & 0x3ffffff);
  { uint32_t x122 = (x73 + x117);
  { uint32_t x123 = (x122 >> 0x1a);
  { uint32_t x124 = (x122 & 0x3ffffff);
  out[0] = x124;
  out[1] = (x123 + x79);
  out[2] = x85;
  out[3] = x91;
  out[4] = x97;
  out[5] = x103;
  out[6] = x109;
  out[7] = x115;
  out[8] = x121;
  out[9] = (x120 + x76);
  out[10] = x82;
  out[11] = x88;
  out[12] = x94;
  out[13] = x100;
  out[14] = x106;
  out[15] = x118;
  }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
}