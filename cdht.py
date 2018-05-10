import sys

from socket import *

try:
	argv = sys.argv
	if len(argv) == 4:
		peer_num = int(argv[1])
    	first_suc = int(argv[2])
    	second_suc = int(argv[3])
except:
    print("Wrong input, failing to open a new xterm")
    sys.exit()





