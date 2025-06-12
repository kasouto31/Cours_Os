:: Authors: Jyn
:: Date : 2025-06-09


:: Recapreseau.bat C:\Stockage\ 
:: Ce script va lancer plusieurs commandes celons la volontés de l'utilisateur
:: Ensuite il va stocker les résultats dans un fichier texte
:: et créer un répertoire de sauvegarde avec une archive des fichiers (si demandé)


@echo off


    if "%1"=="[]" (
        echo Veuillez saisir un repertoire.
        goto fin
    )

    set RepSortie=%1
    if not exist "%RepSortie%" (
        echo Le repertoire %RepSortie% n'existe pas.
        goto fin
    )


    mkdir "%RepSortie%" Logs\
    netstat -ano > "%RepSortie%\Logs\netstat_%computername%_%date%_by_%username%.txt"
    echo Fichier netstat.txt cree dans %RepSortie%\Logs\

:: Il est également possible de lancer d'autres commandes ici tel que : 
    ipconfig /all > "%RepSortie%\Logs\ipconfig_%computername%_%date%_by_%username%.txt"

    set /P test="Voulez-vous creer une archive de sauvegarde ? (O/N) "
    if /I "%test%"=="O" (
        set RepArchive=%RepSortie%\Archive
        if not exist "%RepArchive%" (
            mkdir "%RepArchive%"
        )
        set ArchiveName=Recapreseau_%computername%_%date%_by_%username%.zip
        powershell Compress-Archive -Path "%RepSortie%\Logs" -DestinationPath "%RepArchive%\%ArchiveName%"
        echo Archive creee : %RepArchive%\%ArchiveName%
    ) else (
        echo Aucune archive creee.
    )


:fin
