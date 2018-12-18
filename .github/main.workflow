workflow "docker image" {
  on = "push"
  resolves = ["Docker Tag"]
}

action "Docker Tag" {
  uses = "actions/docker/cli@76ff57a"
  runs = "docker build -t bjornmagnusson/express-demo"
}
