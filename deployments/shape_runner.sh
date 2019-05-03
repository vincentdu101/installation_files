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