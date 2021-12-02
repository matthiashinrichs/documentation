---
order: 50
---

# Minion Targeting

Um auf einzelne oder Gruppen von Systemen zuzugreifen setzt saltstack auf unterschiedliche Selektoren zur gezielten Auswahl von Minions.

## Der einfachste Fall

Die Auswahl eines bestimmten Systems:
`salt vm1.example.com test.ping`

... oder alle Systeme (Vorsicht!!) `salt '*' test.ping`

