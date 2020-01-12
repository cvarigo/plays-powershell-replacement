# Plays Replacement (Recording live games)
# sam little    01.03.2020
# ----------------------------------------
$game = "League of Legends"
$sleep_duration = 5
$recording_executable_cn = "obs64.exe"
$recording_executable_path = "C:\Program Files\obs-studio\bin\64bit"
# ----------------------------------------
Set-Location -Path $recording_executable_path
$record = $False
WHILE ($True) {
    WHILE ($record -eq $False) {
        Write-Output "Sleeping, no process found."
        Start-Sleep -s $sleep_duration
        $record = $($null -ne $(Get-Process "$game" -erroraction 'silentlycontinue'))
    }
    Write-Output "PROCESS FOUND. LAUNCHING $recording_executable_cn..."

    Start-Process -FilePath "$recording_executable_path\$recording_executable_cn" -ArgumentList "--startrecording" 

    WHILE ($record -eq $True) {
        Write-Output "Waiting for $game to close..."
        Start-Sleep -s $sleep_duration
        $record = $($($null -ne $(Get-Process "$game" -erroraction 'silentlycontinue')))
    }

    Write-Output "Attempting to kill $recording_executable_cn..."
    Stop-Process -Name $recording_executable_cn -Force -erroraction 'silentlycontinue'
    Write-Output "Killed $recording_executable_cn."
}