# Salt States

Salt States beschreiben den Soll-Zustand eines Systems. Es gibt nahezu für fast alle Bestandteile eines Systems entsprechende vorgefertigte States, z.B. um Benutzer zu definieren, um Pakete zu installieren (oder zu löschen), Dienste zu starten oder Konfigurationen festzulegen.

States sind idempotent, das bedeutet, dass ein State einen gewünschten Zustand erzeugt in dem bestimmte Befehle ausgeführt werden. Liegt dieser Zustand bereits vor, wird der entsprechende Befehl nicht erneut ausgeführt. Ein State kann mehrfach auf ein System angewendet werden und das Ergebnis ist immer dasselbe.

States sind in YAML geschrieben. Die Dateiendung der State-Files ist .sls

## State-Files organisieren
Die State Files liegen im sogenannten Salt-Fileroot-Verzeichnis, in der Regel ist dieses /srv/salt.
States können direkt in diesem Verzeichnis ablegt werden. Es macht aber durchaus Sinn sie in Unterverzeichnissen zu organisieren.

```  
/srv/salt/
├── john.sls
└── users
    ├── jane.sls
    └── jim.sls
```


## States anwenden
States können sowohl vom Master auf einen oder mehrere Minions gepusht werden als auch direkt vom Minion selbst auf diesem angewendet werden. Die States heissen wie ihr Dateiname (die Endung .sls entfällt). Die Unterverzeichnisse werden durch einen "." dargestellt.

### Vom Master aus (Push)
```shell
salt '*' state.apply john
salt '*' state.apply users.jane
```

### Direkt auf dem Minion (Pull)
```shell
salt-call state.apply john
salt-call state.apply users.jane
```

## Beispiel User anlegen
In diesem Beispiel wird der User John definiert. Es wird zsh als Login-Shell definiert, sowie das Home-Verzeichnis.

```yaml /srv/salt/john.sls
john:
  user.present:
    - fullname: John Doe
    - shell: /bin/zsh
    - home: /home/john
``` 
!!!info Salt State Modules
Eine Liste aller State Module findet sich hier: https://docs.saltproject.io/en/latest/ref/states/all/index.html
!!!