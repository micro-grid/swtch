---
layout: page
title: MTRR Failures
permalink: /mtrr-failure/
---

# MTRR Failures

Here is the MTRR failure reported by the Linux kernel in dmesg.

```
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask C00000000 write-back
[    0.000000]   1 base 400000000 mask FE0000000 write-back
[    0.000000]   2 base 420000000 mask FF0000000 write-back
[    0.000000]   3 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   4 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   5 base 0CC000000 mask FFC000000 uncachable
[    0.000000]   6 base 0CB000000 mask FFF000000 uncachable
[    0.000000]   7 base 42E000000 mask FFE000000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] total RAM covered: 16272M
[    0.000000]  gran_size: 64K 	chunk_size: 64K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 128K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 1M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 2M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 64K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 64K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 64K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 64K 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 128K 	chunk_size: 128K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 1M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 2M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 128K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 128K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 128K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 128K 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 256K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 1M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 2M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 256K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 256K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 256K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 256K 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 512K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 1M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 2M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 512K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 512K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 512K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 512K 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 1M 	chunk_size: 1M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 1M 	chunk_size: 2M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 1M 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 1M 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 1M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 1M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 1M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 1M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 1M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 1M 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 2M 	chunk_size: 2M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 2M 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 2M 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 2M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 2M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 2M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 2M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 2M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 2M 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 4M 	chunk_size: 4M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 4M 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 4M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 4M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 4M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 4M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 4M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 4M 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 8M 	chunk_size: 8M 		num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 8M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 8M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 8M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 8M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 8M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 8M 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 16M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 16M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 32M
[    0.000000]  gran_size: 16M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 16M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 16M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.000000]  gran_size: 16M 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 0G

[    0.000000]  gran_size: 32M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 16M
[    0.000000]  gran_size: 32M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 16M
[    0.000000]  gran_size: 32M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 16M
[    0.000000]  gran_size: 32M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 16M
[    0.000000]  gran_size: 32M 	chunk_size: 1G 		num_reg: 10  	lose cover RAM: 16M

[    0.000000]  gran_size: 64M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 80M
[    0.000000]  gran_size: 64M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 80M
[    0.000000]  gran_size: 64M 	chunk_size: 256M 	num_reg: 9  	lose cover RAM: 80M
[    0.000000]  gran_size: 64M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 80M
[    0.000000]  gran_size: 64M 	chunk_size: 1G 		num_reg: 9  	lose cover RAM: 80M
[    0.000000]  gran_size: 64M 	chunk_size: 2G 		num_reg: 10  	lose cover RAM: 80M

[    0.000000]  gran_size: 128M 	chunk_size: 128M 	num_reg: 7  	lose cover RAM: 144M
[    0.000000]  gran_size: 128M 	chunk_size: 256M 	num_reg: 9  	lose cover RAM: 144M
[    0.000000]  gran_size: 128M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 144M
[    0.000000]  gran_size: 128M 	chunk_size: 1G 		num_reg: 9  	lose cover RAM: 144M
[    0.000000]  gran_size: 128M 	chunk_size: 2G 		num_reg: 10  	lose cover RAM: 144M

[    0.000000]  gran_size: 256M 	chunk_size: 256M 	num_reg: 5  	lose cover RAM: 400M
[    0.000000]  gran_size: 256M 	chunk_size: 512M 	num_reg: 5  	lose cover RAM: 400M
[    0.000000]  gran_size: 256M 	chunk_size: 1G 		num_reg: 6  	lose cover RAM: 400M
[    0.000000]  gran_size: 256M 	chunk_size: 2G 		num_reg: 7  	lose cover RAM: 400M
[    0.000000]  gran_size: 512M 	chunk_size: 512M 	num_reg: 5  	lose cover RAM: 400M
[    0.000000]  gran_size: 512M 	chunk_size: 1G 		num_reg: 6  	lose cover RAM: 400M
[    0.000000]  gran_size: 512M 	chunk_size: 2G 		num_reg: 7  	lose cover RAM: 400M

[    0.000000]  gran_size: 1G 	chunk_size: 1G 	num_reg: 4  	lose cover RAM: 912M
[    0.000000]  gran_size: 1G 	chunk_size: 2G 	num_reg: 4  	lose cover RAM: 912M
[    0.000000]  gran_size: 2G 	chunk_size: 2G 	num_reg: 3  	lose cover RAM: 1936M
[    0.000000] mtrr_cleanup: can not find optimal value
[    0.000000] please specify mtrr_gran_size/mtrr_chunk_size

```

