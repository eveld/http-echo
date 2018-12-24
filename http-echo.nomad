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
                  "GetterSource": "https://storage.googleapis.com/erik-playground/http-echo",
                  "RelativeDest": "local/"
                }],
                "Config": {
                    "command": "http-echo"
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
                "Attempts": 10,
                "Delay": 30000000000,
                "DelayFunction": "exponential",
                "Interval": 10,
                "MaxDelay": 3600000000000,
                "Unlimited": true
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