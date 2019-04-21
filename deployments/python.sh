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
    virtualenv -p python3 env
    source ./env/bin/activate
}

function clone_app_repository() {
    printf "Fetching app"

    # Get App
    echo ======= Cloning App =======
    if [[ -d ~/wildfire-server]]; then
        sudo rm -rf ~/wildfire-server
        git clone https://github.com/vincentdu101/Wildfire-Analyzer-Predictor-System.git ~/wildfire-server
        cd ~/wildfire-server/
    else
        git clone https://github.com/vincentdu101/Wildfire-Analyzer-Predictor-System.git ~/wildfire-server
        cd ~/wildfire-server/
    fi
}

function setup_app() {
    printf "Setting up App"
    setup_env

    # Install required dependencies
    echo ======= Installing required packages =======
    pip install -r requirements.txt
}

function setup_env() {
    printf "Setting up initial Environment"

    # Setting up env file
    sudo cat > ~/.env <<EOF
        export APP_CONFIG = "production"
        export FLASK_APP=app.py
EOF
    source ~/.env
}

function setup_nginx() {
    printf "Setting up nginx"

    echo ======= Installing nginx =======
    sudo apt-get install -y nginx

    # Configure nginx routing 
    echo ======= Configuring nginx =======
    echo ======= Removing default config =======
    sudo rm -rf /etc/nginx/sites-available/default
    sudo rm -rf /etc/nginx/sites-enabled/default

    echo ======= Replace config file =======
    sudo bash -c 'cat <<EOF > /etc/nginx/sites-available/default
    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        server_name _;

        location / {
            # reverse proxy and serve the app
            # running on the localhost:8000
            proxy_pass http://127.0.0.1:8000/;
            proxy_set_header HOST \$host;
            proxy_set_header X-Forwarded-Proto \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        }
    }
EOF'

    echo ======= Create a symbolic link of the file to sites-enabled =======
    sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

    # Ensure nginx server is running 
    echo ======= Check nginx server status
    sudo systemctl restart nginx 
    sudo nginx -t     
}

function create_launch_script() {
    printf "Creating a launch script"

    sudo cat > /home/ubuntu/launch.sh <<EOF
    #!/bin/bash
    cd ~/wildfire-server
    source ~/.env
    source ~/env/bin/activate
    gunicorn app:APP -D
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
    sudo bash /home/ubuntu/launch.sh
}


# Runtime
init_worker
setup_python_env
clone_app_repository
setup_app
setup_nginx
create_launch_script
configure_startup_service
launch_app