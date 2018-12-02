# Following the instructions from:
# https://docs.docker.com/install/linux/docker-ce/centos/#install-using-the-repository

include:
  - pip

docker-package-requirements:
  pkg.installed:
    - pkgs:
      - yum-utils: latest
      - device-mapper-persistent-data: latest
      - lvm2: latest

docker-yum-repository:
  cmd.run:
    - name: yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

docker-package:
  pkg.installed:
    - name: docker-ce
    - version: latest

docker-py-package:
  pip.installed:
    - name: docker-py
    - version: latest

docker-config:
  file.managed:
    - name: /etc/default/docker
    - source: salt://docker/files/docker.conf
    - template: jinja
    - mode: 644
    - user: root

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: /etc/default/docker
      - pkg: docker-package

docker-py:
  pip.installed:
    - name: docker-py
    - version: latest
    - reload_modules: True