## Power Platform Desktop Devops
# Desktop Init Scripts

The repo contains a [powershell script](desktop-init.ps1) and subscripts which can be used to prepare a desktop environment for Power Platform Desktop Devops.

## Sandbox Easy Start
To set up a sandbox, use the following commands to run the script as is.

```powershell
Set-ExecutionPolicy -ExecutionPolicy ByPass
iex "& { $(irm  https://raw.githubusercontent.com/rvmillett/PP-DeskTopDevops-Init/refs/heads/main/desktop-init.ps1) }"
```

## License

[MIT](https://choosealicense.com/licenses/mit/)



    
