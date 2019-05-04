function setup_node_environment() {
    printf "Setting up node environment"

    # download nvm
    echo Downloading nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

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
    yarn start:dev
EOF

    sudo chmod 744 /home/ubuntu/shape_runner_launch.sh
    echo Ensure script is executable
    ls -al ~/shape_runner_launch.sh
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
launch_app