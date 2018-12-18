workflow "docker image" {
  on = "push"
  resolves = [
    "Push Docker image"
  ]
}

action "Build Docker image" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["NPM test"]
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

action "NPM install" {
  uses = "actions/npm@c555744"
  args = "install"
}

action "NPM test" {
  uses = "actions/npm@c555744"
  needs = ["NPM install"]
  args = "test"
}
