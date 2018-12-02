include:
  - docker

docker-gogs-image-present:
  docker_image.present:
    - name: gogs/gogs
    - version: latest

docker-gogs-container-running:
  docker_container.running:
    - image: gogs/gogs:latest
    - name: gogs
    - restart_policy: always
    - volumes:
      - /vagrant/gogs-data:/data
      - /vagrant/gogs-conf:/data/gogs/conf/
    - port_bindings: "10022:22,3000:3000"
    - require:
      - docker_image: docker-gogs-image-present