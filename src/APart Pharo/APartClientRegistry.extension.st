Extension { #name : #APartClientRegistry }

{ #category : #'*APart Pharo' }
APartClientRegistry >> openClientsForPart: aPart application: anApplication [
	"If several clients of different types are active for the part, a #openOnPart: is called for each one.
If several clients are available per type, the part has to decide via callback (see #findClientClassesForPart :). "
	"DE:Falls für den Part mehrere Clients unterschiedlicher Typen aktiv sind, wird für jeden ein #openOnPart: aufgerufen.
	Falls pro Typ mehrere Clients verfügbar sind, muss der Part per callback entscheiden (siehe #findClientClassesForPart:)."

	| clientClasses |
	clientClasses := self findClientClassesForPart: aPart.
	^ clientClasses collect: [:clientClass | clientClass openOnPart: aPart application: anApplication]
]
