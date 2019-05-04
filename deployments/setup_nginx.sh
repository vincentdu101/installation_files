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
    sudo cp -rf ./default /etc/nginx/sites-available/default

    echo ======= Create a symbolic link of the file to sites-enabled =======
    sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

    # Ensure nginx server is running 
    echo ======= Check nginx server status
    sudo systemctl restart nginx 
    sudo nginx -t     
}

# Runtime
setup_nginx