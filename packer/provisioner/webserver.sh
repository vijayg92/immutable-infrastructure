#!/bin/bash
set -ex

function configure_infra() {
  yum update -y
  yum install -y git python3 python3-pip
  test -d /opt/flask-hello-world || git clone https://github.com/vijayg92/flask-hello-world /opt/flask-hello-world
  pip3 install -r /opt/flask-hello-world/requirements.txt
  nohup python3 /opt/flask-hello-world/hello.py &
  curl -I http://$(hostname -i)
}

function validate_infra() {
  gem --version || yum install -y gem
  sudo gem install bundler --no-ri --no-rdoc
  cd /tmp/serverspec
  bundle install --path=vendor
  bundle exec rake spec
}

### Main Function - Call ##
configure_infra
validate_infra