Trait {
	#name : #APTPartWithFocus,
	#instVars : [
		'hasFocus'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APTPartWithFocus >> activeFocus [ 

	^ self hasFocus
]

{ #category : #accessing }
APTPartWithFocus >> canAcceptFocus [

	self explicitRequirement
]

{ #category : #accessing }
APTPartWithFocus >> canLoseFocus [

	self explicitRequirement
]

{ #category : #accessing }
APTPartWithFocus >> focusChanged [

	self explicitRequirement
]

{ #category : #accessing }
APTPartWithFocus >> hasFocus [ 

	^ hasFocus ifNil: [ ^ super hasFocus ]
]

{ #category : #accessing }
APTPartWithFocus >> loseFocus [

	self canLoseFocus ifFalse: [ ^ false ].
	hasFocus := false.
	self focusChanged.
	^ true
]

{ #category : #accessing }
APTPartWithFocus >> takeFocus [ 

	"returns true if the focus was accepted"
	
	| oldPartWithFocus |
	
	self canAcceptFocus ifFalse: [ ^ false ].
	
	oldPartWithFocus := self partWithFocus.
	oldPartWithFocus = self ifTrue: [
		"part focues is the same but we may lose keyboard focus" 
		self takeKeyboardFocus.	
		^ true ].
	
	oldPartWithFocus ifNotNil: [ :aPart |
		aPart loseFocus ifFalse: [ ^ false ]
	].
	hasFocus := true.
	self focusChanged.	
	^ true
]
