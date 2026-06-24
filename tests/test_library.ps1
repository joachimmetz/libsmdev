# Tests library functions and types.

$LibraryTests = "ata error notify optical_disc scsi sector_range string support track_value"
$OptionSets = "" -split " "

. .\test_functions.ps1

$TestExecutablesDirectory = GetTestExecutablesDirectory

If (-Not (Test-Path ${TestExecutablesDirectory}))
{
	Write-Error "Missing test executables directory"

	Exit ${ExitFailure}
}

$Result = ${ExitSuccess}

Foreach (${TestName} in ${LibraryTests} -split " ")
{
	# Split will return an array of a single empty string when LibraryTests is empty.
	If (-Not (${TestName}))
	{
		Continue
	}
	$ResultRun = RunTestBinary ${TestExecutablesDirectory} "smdev_test_${TestName}"

	If ((${ResultRun} -ne ${ExitSuccess}) -And (${ResultRun} -ne ${ExitIgnore}))
	{
		$Result = ${ResultRun}
	}
}

$ResultRun = RunTestBinaryWithInput ${TestExecutablesDirectory} "smdev_test_handle" "\\.\PhysicalDrive0"

If ((${ResultRun} -ne ${ExitSuccess}) -And (${ResultRun} -ne ${ExitIgnore}))
{
	$Result = ${ResultRun}
}
$ResultRun = RunTestBinaryWithInput ${TestExecutablesDirectory} "smdev_test_handle" "\\.\C:"

If ((${ResultRun} -ne ${ExitSuccess}) -And (${ResultRun} -ne ${ExitIgnore}))
{
	$Result = ${ResultRun}
}
Exit ${Result}
