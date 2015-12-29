 Test keys
===========

Test keys, for testing purposes only!
If you encrypt using these, it's possbile for anyone to decrypt your traffic!

Generate your own using:
	
    openssl genrsa -out test.key 2048
    openssl req -new -key test.key -out test.csr
    openssl x509 -req -days 3650 -in test.csr -signkey test.key -out test.crt
    rm test.csr 
