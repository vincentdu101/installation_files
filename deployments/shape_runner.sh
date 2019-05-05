function setup_node_environment() {
    printf "Setting up node environment"

    # download nvm
    echo Downloading nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    source ~/.nvm/nvm.sh

    # install the latest node version
    echo Install the latest node version
    nvm install --lts

    # use the latest node version
    echo Use the latest node version
    nvm use --lts 

    # install yarn globally
    npm install -g yarn

    # install webpack globally
    npm install -g webpack
}

function clone_app_repository() {
    printf "Fetching app"

    # get app
    echo Getting application
    sudo rm -rf ~/shape-runner
    git clone https://github.com/vincentdu101/human-pose-detection-3d.git ~/shape-runner
    cd ~/shape-runner
}

function setup_app() {
    printf "Setting up App"

    # setup app dependencies
    echo Setting up App
    yarn
}

function create_launch_script() {
    printf "Creating launch script"
    sudo rm -rf home/ubuntu/shape_runner_launch.sh
    sudo cat > /home/ubuntu/shape_runner_launch.sh <<EOF
    #!/bin/bash
    cd ~/shape-runner
    nvm use --lts
    yarn start:dev
EOF

    sudo chmod 744 /home/ubuntu/shape_runner_launch.sh
    echo Ensure script is executable
    ls -al ~/shape_runner_launch.sh
}

function configure_startup_service() {
    printf "Configure startup service"

    sudo bash -c "cat > /etc/systemd/system/shape-runner.service <<EOF
    [Unit]
    Description=shape-runner startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/shape_runner_launch.sh
    
    [Install]
    WantedBy=multi-user.target
EOF"
    
    sudo chmod 644 /etc/systemd/system/shape-runner.service
    sudo systemctl daemon-reload
    sudo systemctl enable shape-runner.service
    sudo systemctl start shape-runner.service
    sudo service shape-runner status
}

function launch_app() {
    printf "Serving the app"
    sudo nohup ~/shape_runner_launch.sh &
}

# Runtime
setup_node_environment
clone_app_repository
setup_app
create_launch_script
configure_startup_service
launch_app