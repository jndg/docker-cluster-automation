docker_packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-buildx-plugin
      - docker-compose-plugin
    - refresh: True  # Ensures package list is updated

docker_service:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker_packages

docker_user_group:
  cmd.run:
    - name: usermod -aG docker {{ grains['username'] }}
    - unless: groups {{ grains['username'] }} | grep -q docker
    - require:
      - pkg: docker_packages
