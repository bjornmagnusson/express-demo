workflow "docker image" {
  on = "push"
  resolves = ["Build Docker image"]
}

action "Build Docker image" {
  uses = "actions/docker/cli@76ff57a"
  runs = "docker build -t bjornmagnusson/express-demo ."
}
