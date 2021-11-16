"
APFilterModuleStringPattern erlaubt die Filterung auf Basis eines String-Patterns als model. Die Ergänzung des Wildcard-Zeichens erfolgt automatisch, sofern sie nicht per Konfiguration abgeschaltet wird.

"
Class {
	#name : #APFilterModuleStringPattern,
	#superclass : #APGenericFilterModule,
	#instVars : [
		'shallAppendWildcard'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APFilterModuleStringPattern >> initOn: aModel [

	super initOn: aModel.
	shallAppendWildcard := true
]

{ #category : #accessing }
APFilterModuleStringPattern >> shallAppendWildcard [

	^shallAppendWildcard
]

{ #category : #accessing }
APFilterModuleStringPattern >> shallAppendWildcard: anObject [

	shallAppendWildcard := anObject
]

{ #category : #private }
APFilterModuleStringPattern >> valueForFilterBlock [

	| p |
	p := super valueForFilterBlock.
	shallAppendWildcard ifFalse: [^p].
	p size = 0 ifTrue: [^p].
	(p indexOf: $*) = 0 ifTrue: [p := p , '*'].
	^p
]
