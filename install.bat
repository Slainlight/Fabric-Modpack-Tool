@echo off
REM get fabric
curl https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.6.1.51/fabric-installer-0.6.1.51.jar --output ".script\fabric.jar"
java -jar .script/fabric.jar client -dir %APPDATA%\.minecraft"

REM ------------------
REM copy into minecraft

del %APPDATA%\.minecraft\options.txt
xcopy .script\options.txt %APPDATA%\.minecraft\options.txt*

robocopy %APPDATA%\.minecraft\mods backup
del %APPDATA%\.minecraft\mods\*.jar
xcopy mods\* %APPDATA%\.minecraft\mods\* /Y

xcopy config\* %APPDATA%\.minecraft\config\* /Y

xcopy shaderpacks\* %APPDATA%\.minecraft\shaderpacks\* /Y

REM ------------------

REM take options and set resource packs from mods
del .script\options.txt
cscript /nologo ".script\replace.vbs" > ".script\newfile"
ren .script\newfile options.txt

REM copy resourcepacks into minecraft
xcopy resourcepacks\MC+Connected+CTM+v1.1.zip %APPDATA%\.minecraft\resourcepacks\MC+Connected+CTM+v1.1.zip* /y

