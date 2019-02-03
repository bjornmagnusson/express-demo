workflow "docker image" {
  on = "push"
  resolves = [
    "Push Docker manifest"
  ]
}

action "Build Docker image" {
  uses = "actions/docker/cli@master"
  args = "build -t bjornmagnusson/express-demo:$GITHUB_SHA ."
}

action "Login to Docker Registry" {
  uses = "actions/docker/login@master"
  needs = ["Build Docker image"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Push Docker image" {
  uses = "actions/docker/cli@master"
  needs = ["Login to Docker Registry"]
  args = "push bjornmagnusson/express-demo:$GITHUB_SHA"
}

action "Create Docker manifest" {
  uses = "actions/docker/cli@master"
  needs = "Push Docker image"
  env = {
    DOCKER_CLI_EXPERIMENTAL = "enabled"
  }
  args = "manifest create bjornmagnusson/express-demo:$GITHUB_SHA bjornmagnusson/express-demo:$GITHUB_SHA"
}

action "Push Docker manifest" {
  uses = "actions/docker/cli@master"
  needs = "Create Docker manifest"
  env = {
    DOCKER_CLI_EXPERIMENTAL = "enabled"
  }
  args = "manifest push bjornmagnusson/express-demo:$GITHUB_SHA"
}
