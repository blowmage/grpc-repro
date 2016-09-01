# GRPC hang on forked process reproduction

This project is to reproduce the GRPC client hanging when called from a forked process. To run the repro check the git repo out and do the following:

```
$ # First, run bundler to get all the dependencies installed
$ bundle update
$ # Now we can run the repro with the run task
$ rake run
$ # If you want to run against a specific Google Cloud project, pass that in
$ rake run[my-project-id-here]
```

This will create a new GRPC stub object and a top-level method to make a call to Datastore and invoke a lookup request. The response is received and then printed.

This method will then be called from a forked process, but the process will hang on the API call.
