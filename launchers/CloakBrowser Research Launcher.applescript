property toolVersion : "1.0"

on run
	set launcherPath to POSIX path of ((path to me) as text)
	set startScript to do shell script "cd $(dirname " & quoted form of launcherPath & ")/.. && pwd -P"
	set startScript to startScript & "/scripts/start-research-console.sh"
	do shell script quoted form of startScript
end run
