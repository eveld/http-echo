{
    "Job": {
        "ID": "echo",
        "Name": "echo",
        "Type": "service",
        "Priority": 50,
        "Datacenters": [
            "dc1"
        ],
        "TaskGroups": [{
            "Name": "echo",
            "Count": 1,
            "Tasks": [{
                "Name": "http-echo",
                "Driver": "exec",
                "User": "",
                "Artifacts": [{
                  "GetterSource": "https://storage.googleapis.com/erik-playground/github_eveld_http-echo/app"
                }],
                "Config": {
                    "command": "local/app"
                },
                "Resources": {
                    "CPU": 500,
                    "MemoryMB": 256
                },
                "Leader": false
            }],
            "RestartPolicy": {
                "Interval": 300000000000,
                "Attempts": 10,
                "Delay": 25000000000,
                "Mode": "delay"
            },
            "ReschedulePolicy": {
                "Attempts": 0
            },
            "EphemeralDisk": {
                "SizeMB": 300
            }
        }],
        "Update": {
            "MaxParallel": 1,
            "MinHealthyTime": 10000000000,
            "HealthyDeadline": 180000000000,
            "AutoRevert": false,
            "Canary": 0
        }
    }
}