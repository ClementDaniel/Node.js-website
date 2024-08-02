#!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              curl -sL https://rpm.nodesource.com/setup_14.x | bash -
              yum install -y nodejs
              git clone https://github.com/ClementDaniel/Node.js-website /home/ec2-user/quest
              cd /home/ec2-user/quest
              docker build -t quest-app .
              docker run -d -p 80:3000 --name quest-app quest-app
              EOF