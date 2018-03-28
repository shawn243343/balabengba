from socket import *
import sys

serverPort = int(sys.argv[1]) # change this port number if required
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('127.0.0.1', serverPort))
serverSocket.listen(10)
print ("The server is ready to receive")
while 1:
    connectionSocket, addr = serverSocket.accept()#connectionSocket = clientsocket
    sentence = connectionSocket.recv(1024) #bytes of buf
    #print(type(sentence))
    #capitalizedSentence = sentence.upper()
    filename = sentence.split(b" ")[1][1:]
    #filename = filename.split(b".")[0]
    
    #print(filename)
    
    try:
        with open(filename, "rb") as fh: #IOError
            connectionSocket.send('HTTP/1.1 200 OK\r\n\r\n'.encode()) #a sign of header part over \r\n\r\n create a new line; #b(string)
            fcontent = fh.read()
        #print("sending ")
        connectionSocket.send(fcontent)
    except IOError:
        print("not found")
        connectionSocket.send('HTTP/1.1 404 NOT FOUND\r\n\r\n'.encode())

    connectionSocket.close()

#split('.')

