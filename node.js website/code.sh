#!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              curl -sL https://rpm.nodesource.com/setup_14.x | bash -
              yum install -y nodejs
              git clone https://github.com/ClementDaniel/Node.js-website /home/ec2-user/my-node-app
              cd /home/ec2-user/my-node-app
              docker build -t my-node-app .
              docker run -d -p 8080:8080 my-node-app 
              EOF

                # openssl genrsa -out ca-key.pem 4096
                # openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
                # openssl genrsa -out server-key.pem 4096
                # openssl req -subj "/CN=127.0.0.1" -sha256 -new -key server-key.pem -out server.csr
                # echo subjectAltName = IP:127.0.0.1,DNS:X,DNS:X > extfile.cnf
                # openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
                # -CAcreateserial -out server-cert.pem -extfile extfile.cnf
                # openssl genrsa -out key.pem 4096
                # openssl req -subj '/CN=client' -new -key key.pem -out client.csr
                # echo extendedKeyUsage = clientAuth > extfile.cnf
                # openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
                # -CAcreateserial -out cert.pem -extfile extfile.cnf
                # rm -v client.csr server.csr
                # chmod -v 0400 ca-key.pem key.pem server-key.pem
                # chmod -v 0444 ca.pem server-cert.pem cert.pem