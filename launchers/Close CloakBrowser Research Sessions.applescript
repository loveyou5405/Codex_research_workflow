property toolVersion : "0.6"

on run
	set launcherPath to POSIX path of ((path to me) as text)
	set stopScript to do shell script "cd $(dirname " & quoted form of launcherPath & ")/.. && pwd -P"
	set stopScript to stopScript & "/scripts/stop-research-console.sh"
	do shell script quoted form of stopScript
	display notification "本地控制台、測試瀏覽器、上傳暫存、下載文獻與臨時截圖已清理。v0.6" with title "ARS Research Console"
end run
