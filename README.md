installation_files
==================

Bash installation Files for Popular Tools and Technologies


Deployments

Services
https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files

# tailing service log
journalctl -u service-name -e

# renew ssl cert
sudo systemctl stop nginx
sudo certbot renew
sudo systemctl start nginx