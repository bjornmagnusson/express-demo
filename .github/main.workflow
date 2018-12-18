workflow "docker image" {
  on = "push"
  resolves = ["Docker Registry"]
}

action "Build Docker image" {
  uses = "actions/docker/cli@76ff57a"
  runs = "docker build -t bjornmagnusson/express-demo ."
}

action "Docker Registry" {
  uses = "actions/docker/login@76ff57a"
  needs = ["Build Docker image"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}
