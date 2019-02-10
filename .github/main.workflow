workflow "docker image" {
  on = "push"
  resolves = [
    "Push Docker manifest"
  ]
}

action "Build Docker image" {
  uses = "actions/docker/cli@master"
  args = "build --target standard -t bjornmagnusson/express-demo:$GITHUB_SHA ."
}

action "Build Docker image ARM" {
  uses = "actions/docker/cli@master"
  args = "build --target arm -t bjornmagnusson/express-demo:arm-$GITHUB_SHA ."
}

action "Login to Docker Registry" {
  uses = "actions/docker/login@master"
  needs = ["Build Docker image","Build Docker image ARM"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Push Docker images" {
  uses = "actions/docker/cli@master"
  needs = ["Login to Docker Registry"]
  args = "push bjornmagnusson/express-demo"
}

action "Create Docker manifest" {
  uses = "actions/docker/cli@master"
  needs = ["Push Docker images"]
  env = {
    DOCKER_CLI_EXPERIMENTAL = "enabled"
  }
  args = "manifest create bjornmagnusson/express-demo:$GITHUB_SHA bjornmagnusson/express-demo:$GITHUB_SHA bjornmagnusson/express-demo:arm-$GITHUB_SHA"
}

action "ARM annotate manifest" {
  uses = "actions/docker/cli@master"
  needs = "Create Docker manifest"
  env = {
    DOCKER_CLI_EXPERIMENTAL = "enabled"
  }
  args = "manifest annotate bjornmagnusson/express-demo:$GITHUB_SHA bjornmagnusson/express-demo:arm-$GITHUB_SHA --os linux --arch arm"
}

action "Manifest" {
  uses = "actions/docker/cli@master"
  needs = "ARM annotate manifest"
  env = {
    DOCKER_CLI_EXPERIMENTAL = "enabled"
  }
  args = "manifest inspect bjornmagnusson/express-demo:$GITHUB_SHA"
}

action "Push Docker manifest" {
  uses = "actions/docker/cli@master"
  needs = "Manifest"
  env = {
    DOCKER_CLI_EXPERIMENTAL = "enabled"
  }
  args = "manifest push bjornmagnusson/express-demo:$GITHUB_SHA"
}
