#!/bin/bash
for (( i=0; i < 5; i++ ))
do
	osascript -e 'tell application "Terminal" to do script "cd sandbox/ifpr/dobutsu-shogui/core; java -classpath \"bin:mysql-connector-java-5.1.44-bin.jar\" ai.memoria.SimuladorAleatorioSalvarBancoDeDados; exit"'
done