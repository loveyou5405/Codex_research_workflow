property toolVersion : "1.0"

on run
	set launcherPath to POSIX path of ((path to me) as text)
	set stopScript to do shell script "cd $(dirname " & quoted form of launcherPath & ")/.. && pwd -P"
	set stopScript to stopScript & "/scripts/stop-research-console.sh"
	do shell script quoted form of stopScript
	display notification "暫存已清理；reports 與 output_PDF 已保留。v1.0" with title "ARS Research Console"
end run
