init_swarm:
  cmd.run:
    - name: docker swarm init --advertise-addr=192.168.10.11
    - unless: "docker info | grep 'Swarm: active'"
