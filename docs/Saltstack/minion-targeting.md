---
order: 50
---

# Minion Targeting

Um auf einzelne oder Gruppen von Systemen zuzugreifen setzt saltstack auf unterschiedliche Selektoren zur gezielten Auswahl von Minions.

## Der einfachste Fall

Die Auswahl eines bestimmten Systems:
`salt vm1.example.com test.ping`

... oder alle Systeme (Vorsicht!!) `salt '*' test.ping`

## Targeting mit Pillars und Grains

Minions anhand von Grains auswählen:
`salt -G 'os:Fedora' test.version`

Mit Pillars geht es so:
`salt -I 'somekey:specialvalue' test.version`


## Compound Matcher
Noch granularer lassen sich Minions mit einer Kombination verschiedener Matcher selektieren.

`salt -C 'webserv* and G@os:Debian or E@web-dc1-srv.*' test.version`

Dabei lassen sich alle Matcher beliebig kombinieren

## Übersicht aller Matcher

| Buchstabe |     Match Typ     |                   Beispiel                  |
|-----------|-------------------|---------------------------------------------|
| G         | Grains glob       | G@os:Ubuntu                                 |
| E         | PCRE Minion ID    | E@web\d+\.(dev&#124;qa&#124;prod)\.loc      |
| P         | Grains PCRE       | P@os:(RedHat&#124;Fedora&#124;CentOS)       |
| L         | List of minions   | L@mini1.ex.com,mi3.domain.com or bl*.me.com |
| I         | Pillar glob       | I@pdata:foobar                              |
| J         | Pillar PCRE       | J@pdata:^(foo&#124;bar)$                    |
| S         | Subnet/IP address | S@192.168.1.0/24 or S@192.168.1.100         |
| R         | Range cluster     | R@%foo.bar                                  |
| N         | Nodegroups        | N@group1                                    |

Weitere Infos zum Range-Cluster-Matcher: https://docs.saltproject.io/en/latest/topics/targeting/range.html
