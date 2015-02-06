@echo off
:main
for /f "delims=" %%x in (config.txt) do (set "%%x")
echo %services%
echo %operations%

for %%a in (%services%) do (
	echo %%a
	for %%b in (%operations%) do (
		set result = "PASS"
		echo %%b
		mkdir %%a\%%b\output
		curl --header "Content-Type: text/xml;charset=UTF-8"  -d @%%a\%%b\soapRequest_1.txt http://www.predic8.com:8080/crm/CustomerService -o %%a\%%b\output\response_1.txt

		fc %%a\%%b\expectResult_1.txt %%a\%%b\output\response_1.txt > nul
		if errorlevel 1 (
			@echo %date%:%%a\%%b\request_1 - FAIL >> %%a\%%b\output\result.txt
			echo FAIL
		) else (
			@echo %date%:%%a\%%b\request_1 - PASS >> %%a\%%b\output\result.txt
			echo PASS
		)

	)
)


:end
endlocal