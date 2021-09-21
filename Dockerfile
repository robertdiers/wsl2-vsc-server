FROM codercom/code-server:latest

RUN sudo cat /etc/os-release

#install environment requirements
RUN sudo apt update
RUN sudo apt -y upgrade
RUN sudo apt install -y git curl
RUN sudo apt install -y openjdk-11-jdk
RUN sudo apt install -y maven

#install docker to startup environment
RUN sudo apt install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
RUN sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt update
RUN sudo apt install -y docker-ce docker-ce-cli containerd.io

#install docker compose
RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose

#install code extensions to browse code from all projects
RUN code-server --install-extension redhat.java
RUN code-server --install-extension GabrielBB.vscode-lombok
RUN code-server --install-extension ms-azuretools.vscode-docker

#configure git
RUN git config --global user.email "robert.diers@accenture.com"
RUN git config --global user.name "Robert Diers"
