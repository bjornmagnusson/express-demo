workflow "docker image" {
  on = "push"
  resolves = ["Docker Registry"]
}

action "Build Docker image" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t bjornmagnusson/express-demo:$GITHUB_SHA ."
}

action "Docker Registry" {
  uses = "actions/docker/login@76ff57a"
  needs = ["Build Docker image"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}
