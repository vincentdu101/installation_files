function setup_node_environment() {
    printf "Setting up node environment"

    # download nvm
    echo Downloading nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    source ~/.nvm/nvm.sh

    echo install latest node version
    nvm install --lts 

    echo use the latest node version
    nvm use --lts

    # install globally dependencies
    npm install -g yarn
    npm install -g typescript
    npm install -g @angular/cli --latest
    npm install -g babel-cli
    npm install -g yarn
}

function clone_app_repo() {
    echo getting application

    sudo rm -rf ~/flagship-client
    git clone https://github.com/vincentdu101/flagship-client.git ~/flagship-client
    cd ~/flagship-client
}

function setup_app() {
    # setup app dependencies
    echo setting up app
    yarn
}

function create_launch_script() {
    echo creating launch script
    sudo rm -rf home/ubuntu/flagship_client_launch.sh
    sudo cat > /home/ubuntu/flagship_client_launch.sh <<EOF
    #!/bin/bash
    cd ~/flagship-client
    source ~/.nvm/nvm.sh
    nvm use --lts
    ng build --env=prod
    ng serve --prod=true
EOF

    sudo chmod 744 /home/ubuntu/flagship_client_launch.sh
    echo ensure script is executable
    ls -al ~/flagship_client_launch.sh
}

function configure_startup_service() {
    echo configure startup service

    sudo bash -c "cat > /etc/systemd/system/flagship-client.service <<EOF
    [Unit]
    Description=flagship-client startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/flagship_client_launch.sh

    [Install]
    WantedBy=multi-user.target 
EOF"

    sudo chmod 644 /etc/systemd/system/flagship-client.service
    sudo systemctl daemon-reload
    sudo systemctl enable flagship-client.service
    sudo systemctl start flagship-client.service
    sudo service flagship-client status
}

function launch_app() {
    echo "serving the app"
    sudo nohup ~/flagship_client_launch.sh &
}

# Runtime 
setup_node_environment
clone_app_repo
setup_app
create_launch_script
configure_startup_service
launch_app