docker_gpg_key:
  file.managed:
    - name: /etc/apt/keyrings/docker.asc
    - source: https://download.docker.com/linux/debian/gpg
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - skip_verify: True

docker_repository:
  file.managed:
    - name: /etc/apt/sources.list.d/docker.list
    - contents: |
        deb [arch={{ grains['osarch'] }} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian {{ grains['lsb_distrib_codename'] }} stable
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - file: docker_gpg_key

update_pkg_list:
  pkgrepo.managed:
    - name: deb [arch={{ grains['osarch'] }} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian {{ grains['lsb_distrib_codename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - refresh: True
    - require:
      - file: docker_repository

docker:
  pkg.installed:
    - names:
        - docker-ce
        - docker-ce-cli
        - containerd.io
        - docker-buildx-plugin
        - docker-compose-plugin
    - require:
      - pkgrepo: update_pkg_list
