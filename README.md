Welcome to the repository that hosts the running scripts for the Packet Synthesizer application.\
The program files are hosted on Docker Hub here: https://hub.docker.com/r/dacae/packet-synth. This repository serves to host the files that make its use convenient.\
The repository includes two scripts, run-linux.sh and run-windows.sh. The linux script is intended for use on linux, and the windows script is intended for use in WSL.\
The repository also includes some default visual themes that are intended to be packaged with the application.

INSTRUCTIONS:\
First, you must have Docker / Docker Desktop (for WSL users) installed on your computer.\
Download the repository zip file and extract the contents.\
The run script must first be given permission with "chmod +x run-linux.sh", or "chmod +x run-windows.sh" for WSL users.\
For the first run, the application should be launched in the terminal with "./run-linux.sh" or "./run-windows.sh", as you will be prompted for Network Interface selection.\
Once this is complete, the launcher configuration will be saved in the directory as launcher.conf, and the network configuration will be saved as config.json. If the Network Interface was incorrect or ever needs to be changed, it can be manually set in config.json.\
The script will then start the Docker service and automatically launch the application.

NOTE:\
Packet Synthesizer will be able to send real networking packets through the selected interface when running on linux. On windows it will simulate networking packets within the virtualized Docker network.
