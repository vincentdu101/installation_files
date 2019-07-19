function setup_java_environment() {
    echo Setup Java Environment

    sudo apt update
    sudo apt upgrade
    sudo add-apt-repository ppa:linuxuprising/java
    sudo apt update
    sudo apt install oracle-java11-installer
    sudo apt install oracle-java11-set-default
    java --version
}

function setup_maven() {
    echo Setup Maven 

    sudo apt install maven
    mvn -version
}

function setup_mysql() {
    echo Setup MySQL

    sudo apt install mysql-server
    sudo mysql_secure_installation
    mysql -u root -p < ~/smartbart/database/smartbart.sql
}

function clone_app_repo() {
    echo Get Application

    sudo rm -rf ~/smartbart
    git clone https://github.com/vincentdu101/SmartBart.git ~/smartbart
    cd ~/smartbart
}

function setup_app() {
    echo Setting up app
    mvn clean install
}

function create_launch_script() {
    echo Create Launch Script
    sudo rm -rf home/ubuntu/smartbart_server_launch.sh
    sudo cat > /home/ubuntu/smartbart_server_launch.sh <<EOF
    #!/bin/bash
    cd ~/smartbart
    mvn spring-boot:run
EOF

    sudo chmod 744 /home/ubuntu/smartbart_server_launch.sh
    echo ensure script is executable
    ls -al ~/smartbart_server_launch.sh
}

function configure_start_service() {
    echo Configure Startup Service

    sudo bash -c "cat > /etc/systemd/system/smartbart-server.service <<EOF
    [Unit]
    Description=smartbart startup service
    After=network.target

    [Service]
    User=ubuntu
    ExecStart=/bin/bash /home/ubuntu/smartbart_server_launch.sh

    [Install]
    WantedBy=multi-user.target 
EOF"

    sudo chmod 644 /etc/systemd/system/smartbart-server.service
    sudo systemctl daemon-reload
    sudo systemctl enable smartbart-server.service
    sudo systemctl start smartbart-server.service
    sudo service smartbart-server status
}

function launch_app() {
    echo Serve the Application
    sudo nohup ~/smartbart_server_launch.sh &
}

# Runtime
# setup_java_environment
# setup_maven
# setup_mysql
clone_app_repo
setup_app
create_launch_script
configure_start_service
launch_app