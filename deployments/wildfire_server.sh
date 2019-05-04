function init_worker() {
    printf "Setting up Host"

    # Update packages
    echo Updating packages
    sudo apt-get update

    # Export language locale settings
    echo ======= Exporting language locale settings =======
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

    # Install pip3
    echo ======= Install pip3 =======
    sudo apt-get install -y python3-pip

    # Install gunicorn 
    echo ======= Install gunicorn =======
    sudo apt install gunicorn
}

function setup_python_env() {
    printf "Setting up virtual env"

    # Install virtualenv
    echo ======= Installing virtualenv =======
    pip3 install virtualenv
    sudo apt install virtualenv

    # Create virtual environment and activate it
    echo ======= Creating and activating virtual env =======
    virtualenv -p python3 ~/env
    source ~/env/bin/activate
}

function clone_app_repository() {
    printf "Fetching app"

    # Get App
    echo ======= Cloning App =======
    sudo rm -rf ~/wildfire-server
    git clone https://github.com/vincentdu101/Wildfire-Analyzer-Predictor-System.git ~/wildfire-server
    cd ~/wildfire-server/server/models
    export WILDFIRE_SQL=https://s3-us-west-2.amazonaws.com/wildfire-analyzer-system/wildfires.sqlite
    wget ${WILDFIRE_SQL}
    sudo chmod 644 wildfires.sqlite
    cd ..
}

function setup_app() {
    printf "Setting up App"
    setup_env

    # Install required dependencies
    echo ======= Installing required packages =======
    pip install cython
    pip --no-cache-dir install -r ubuntu-requirements.txt
}

function setup_env() {
    printf "Setting up initial Environment"

    # Install python3-flask
    sudo apt install python3-flask

    # Setting up env file
    sudo rm -rf home/ubuntu/.env
    sudo cat > ~/.env <<EOF
        export APP_CONFIG="production"
        export FLASK_APP=app.py
        export FLASK_RUN_PORT=8000
EOF
    source ~/.env
}

function create_launch_script() {
    printf "Creating a launch script"
    sudo rm -rf home/ubuntu/launch.sh
    sudo cat > /home/ubuntu/launch.sh <<EOF
    #!/bin/bash
    cd ~/wildfire-server/server
    source ~/.env
    source ~/env/bin/activate
    flask run
EOF

    sudo chmod 744 /home/ubuntu/launch.sh
    echo ======= Ensuring script is executable =======
    ls -la ~/launch.sh
}

function configure_startup_service() {
    printf "Configure startup service"

    sudo bash -c "cat > /etc/systemd/system/wildfire-server.service <<EOF
    [Unit]
    Description=wildfire-server startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/launch.sh
    
    [Install]
    WantedBy=multi-user.target
EOF"

    sudo chmod 644 /etc/systemd/system/wildfire-server.service
    sudo systemctl daemon-reload
    sudo systemctl enable wildfire-server.service
    sudo systemctl start wildfire-server.service
    sudo service wildfire-server status
}

function launch_app() {
    printf "Serving the app"
    sudo nohup ~/launch.sh &
}


# Runtime
init_worker
setup_python_env
clone_app_repository
setup_app
create_launch_script
configure_startup_service
launch_app