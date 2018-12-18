workflow "docker image" {
  on = "push"
  resolves = ["Build Docker image"]
}

action "Build Docker image" {
  uses = "docker://docker/compose:1.23"
  runs = "docker-compose build"
}
