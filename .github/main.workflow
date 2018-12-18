workflow "docker image" {
  on = "push"
  resolves = ["Push Docker image"]
}

action "Build Docker image" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t bjornmagnusson/express-demo:$GITHUB_SHA ."
}

action "Login to Docker Registry" {
  uses = "actions/docker/login@76ff57a"
  needs = ["Build Docker image"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Push Docker image" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Login to Docker Registry"]
  args = "push bjornmagnusson/express-demo:$GITHUB_SHA"
}
