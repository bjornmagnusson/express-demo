workflow "docker image" {
  on = "push"
  resolves = ["Build Docker image"]
}

action "Build Docker image" {
  uses = "docker://docker/compose:1.23.2"
  runs = "docker-compose build"
}
