function setup_app() {
    printf "Setting up app dependencies"
    yarn global add serve
    cd ~/wildfire-server/client
    yarn
}

function create_launch_script() {
    echo creating launch script
    sudo rm -rf home/ubuntu/wildfire_client_launch.sh
    sudo cat > /home/ubuntu/widlfire_client_launch.sh <<EOF
    #!/bin/bash
    cd ~/wildfire-server/client
    source ~/.nvm/nvm.sh
    nvm use --lts
    yarn build
    serve -s build -l 4000
EOF

    sudo chmod 744 /home/ubuntu/wildfire_client_launch.sh
    sudo ensure script is executable
    ls -al ~/wildfire_client_launch.sh
}

function configure_startup_service() {
    echo configure startup service

    sudo bash -c "cat > /etc/systemd/system/wildfire-client.service <<EOF
    [Unit]
    Description=wildfire-client startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/wildfire_client_launch.sh

    [Install]
    WantedBy=multi-user.target    
EOF"

    sudo chmod 644 /etc/systemd/system/wildfire-client.service
    sudo systemctl daemon-reload
    sudo systemctl enable wildfire-client.service
    sudo systemctl start wildfire-client.service
    sudo service wildfire-client status
}

function launch_app() {
    echo "serving the app"
    sudo nohup ~/wildfire_client_launch.sh &
}

# Runtime
setup_app
create_launch_script
configure_startup_service
launch_app
