sudo docker build -t simulation .
sudo docker run --name test simulation
sudo docker run -i -t simulation /bin/bash
