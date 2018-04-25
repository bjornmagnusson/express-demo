const { events, Job, Group } = require('brigadier')

events.on("exec", () => {
  npmJob = new Job("npm-test", "node:8-alpine", [
      "cd /src",
      "yarn install"
    ])

  npmJob.run().then((result) => {
    console.log(result.toString())
  })
})