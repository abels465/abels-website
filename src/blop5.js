import("blop5")
  .catch(error => {
    if (!error.message.startsWith("Using exceptions for control flow,")) {
      console.error(error);
    }
  })
