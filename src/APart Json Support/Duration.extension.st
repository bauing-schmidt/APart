Extension { #name : #Duration }

{ #category : #'*APart Json Support-converting' }
Duration >> asJsonNumber [

	| numVal |
"	numVal := period.
	scale = 1 ifFalse: [numVal := (numVal * scale) rounded].
"	
	^ nanos

]

{ #category : #'*APart Json Support-converting' }
Duration >> printJsonOn: aStream [
	"Anstelle einer Struktur normiert als Sekundenwert"

	self asJsonNumber printOn: aStream
]
