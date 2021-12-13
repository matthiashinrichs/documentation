# Homelab Setup

Die wichtigsten Infrastrukturbestandteile des Homelabs sind zur Zeit:

- Synology Diskstation
- Virtualisierungsserver (KVM)

## Synology Diskstation (ds920.homenet - 192.168.1.120)

Die Diskstation stellt als zentraler Bestandteil folgende Services zur Verfügung:

- Storage (iSCSI, S3)
- DNS (Zonen: homenet)

## Virtualisierungsumgebung (trinity.homenet - 192.168.1.123)

Die Virtualisierungsumgebung läuft ist ein KVM Host basierend auf openSUSE 15.3 und stellt im Moment folgende Systeme bereit:

|       Hostname       |       IP      |                      Service                      |
|----------------------|---------------|---------------------------------------------------|
| uyuni.home           | 192.168.1.127 | uyuni - Systemverwaltung/Konfigurationsmanagement |
| kube1.server.homenet | 192.168.1.128 | Kubernetes-Master                                 |
| kube2.server.homenet | 192.168.1.129 | Kubernetes-Worker                                 |
| kube3.server.homenet | 192.168.1.130 | Kubernetes-Worker                                 |
| kube4.server.homenet | 192.168.1.131 | Kubernetes-Worker                                 |
