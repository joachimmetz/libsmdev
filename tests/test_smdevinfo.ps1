# Info tool testing script
#
# Version: 20260615

$Profiles = @("smdevinfo")
$OptionSets = "" -split " "

. .\test_functions.ps1

$TestExecutablesDirectory = GetTestExecutablesDirectory

If (-Not (Test-Path ${TestExecutablesDirectory}))
{
	Write-Error "Missing test executables directory"

	Exit ${ExitFailure}
}

$TestDescription = "smdevinfo with input: '\\\\.\\PhysicalDrive0'"
$TestExecutable = "${TestExecutablesDirectory}\smdevinfo.exe"

Invoke-Expression ${TestExecutable} "\\\\.\\PhysicalDrive0"
$Result = $global:LastExitCode

WriteTestResult ${TestDescription} ${Result}

Exit ${Result}

