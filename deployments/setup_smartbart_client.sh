function setup_app() {
    echo Setup App
    source ~/.nvm/nvm.sh
    nvm use --lts

    cd ~/smartbart/src/main/resources/static
    npm install
}

function create_launch_script() {
    echo Create Launch Script
    sudo rm -rf home/ubuntu/smartbart_client_launch.sh
    sudo cat > /home/ubuntu/smartbart_client_launch.sh <<EOF
    #!/bin/bash
    cd ~/smartbart/src/main/resources/static
    source ~/.nvm/nvm.sh
    nvm use --lts
    npm run build
    cd build
    http-server -p 5000
EOF

    sudo chmod 744 /home/ubuntu/smartbart_client_launch.sh
    echo ensure script is executable
    ls -al ~/smartbart_client_launch.sh
}

function configure_startup_service() {
    echo configure startup service
    sudo bash -c "cat > /etc/systemd/system/smartbart-client.service <<EOF
    [Unit]
    Description=smartbart-client startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/smartbart_client_launch.sh

    [Install]
    WantedBy=multi-user.target 
EOF"

    sudo chmod 644 /etc/systemd/system/smartbart-client.service
    sudo systemctl daemon-reload
    sudo systemctl enable smartbart-client.service
    sudo systemctl start smartbart-client.service
    sudo service smartbart-client status
}

function launch_app() {
    echo "serving the smartbart client app"
    sudo nohup ~/smartbart_client_launch.sh &
}

# Runtime
setup_app
create_launch_script
configure_startup_service
launch_app