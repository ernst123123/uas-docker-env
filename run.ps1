# example: 192.168.1.0:0.0
$WSL2IP = ""

if ($WSL2IP -eq "")
{
    Write-Host "please add your WSL 2 IP address in this script"
    Exit 
}
Set-Variable -name DISPLAY -value $WSL2IP
docker run --rm -it -e DISPLAY=$DISPLAY uas_docker_env:1.0