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
}

function setup_mongo_db() {
    echo setting up mongod db

    echo import mongo public key
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

    echo create list source
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

    sudo apt-get update
    echo install mongodb
    sudo apt-get install -y mongodb-org

    echo pin package to specific version
    echo "mongodb-org hold" | sudo dpkg --set-selections
    echo "mongodb-org-server hold" | sudo dpkg --set-selections
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections
}

function run_mongo_db() {
    sudo service mongod start
}

function clone_app_repo() {
    echo getting application

    sudo rm -rf ~/flagship-server
    git clone https://github.com/vincentdu101/FlagShip-Main.git ~/flagship-server
    cd ~/flagship-server
}

function setup_app() {
    # setup app dependencies
    echo setting up app
    npm install
}

function create_launch_script() {
    echo creating launch script
    sudo rm -rf home/ubuntu/flagship_server_launch.sh
    sudo cat > /home/ubuntu/flagship_server_launch.sh <<EOF
    #!/bin/bash
    cd ~/flagship-server
    source ~/.nvm/nvm.sh
    nvm use --lts
    node app.js
EOF

    sudo chmod 744 /home/ubuntu/flagship_server_launch.sh
    echo ensure script is executable
    ls -al ~/flagship_server_launch.sh
}

function configure_startup_service() {
    echo configure startup service

    sudo bash -c "cat > /etc/systemd/system/flagship-server.service <<EOF
    [Unit]
    Description=flagship-server startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/flagship_server_launch.sh

    [Install]
    WantedBy=multi-user.target 
EOF"

    sudo chmod 644 /etc/systemd/system/flagship-server.service
    sudo systemctl daemon-reload
    sudo systemctl enable flagship-server.service
    sudo systemctl start flagship-server.service
    sudo service flagship-server status
}

function launch_app() {
    echo "serving the app"
    sudo nohup ~/flagship_server_launch.sh &
}

# Runtime 
setup_node_environment
setup_mongo_db
run_mongo_db
clone_app_repo
setup_app
create_launch_script
configure_startup_service
launch_app