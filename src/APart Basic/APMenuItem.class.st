Class {
	#name : #APMenuItem,
	#superclass : #Object,
	#instVars : [
		'actionPerformer',
		'enabled',
		'enablementSelector',
		'label',
		'labelImage',
		'submenu',
		'value'
	],
	#category : #'APart Basic-Support'
}

{ #category : #obsolete }
APMenuItem class >> labeled: aCharacterArraySource [
	"Answer a new MenuItem with the given label source, with a specified access character (optional).
	The character after the first ampersand (&) will be the access character for the menu item (for LookPolicy's that have the concept of an access character).  The ampersand will not appear in the label, it just marks the character that should be the access character.  To get an ampersand to appear in the label, use two consecutive ampersands (&&).
	Labels ending in an ellipsis (...) (three consecutive periods) denote that the menu item initiates the beginning of an action (rather than the whole action).  When displayed, a LookPolicy may modify the ending ellipsis if another convention is used for that meaning."

	^super new
		rawLabel: aCharacterArraySource;
		yourself
]

{ #category : #accessing }
APMenuItem >> actionPerformer [
	^ actionPerformer
]

{ #category : #accessing }
APMenuItem >> actionPerformer: anObject [
	actionPerformer := anObject
]

{ #category : #'as yet unclassified' }
APMenuItem >> enabled: enabledBoolean [
	"Make the receiver be enabled on the menu (if enabledBoolean's value is true)
	 otherwise invisible.  When enabled it can be selected on the menu (if it's visible)." 

	enabled := enabledBoolean
]

{ #category : #accessing }
APMenuItem >> enablementSelector [
	^ enablementSelector
]

{ #category : #accessing }
APMenuItem >> enablementSelector: anObject [
	enablementSelector := anObject
]

{ #category : #'as yet unclassified' }
APMenuItem >> hasSubmenu [

	^self submenu ~~ nil
]

{ #category : #'as yet unclassified' }
APMenuItem >> indication: anIndication [

]

{ #category : #'as yet unclassified' }
APMenuItem >> label [ 

	^ label
]

{ #category : #accessing }
APMenuItem >> labelImage [
	^ labelImage
]

{ #category : #accessing }
APMenuItem >> labelImage: anObject [
	labelImage := anObject
]

{ #category : #'as yet unclassified' }
APMenuItem >> rawLabel: aCharacterArraySource [

	label := aCharacterArraySource
]

{ #category : #accessing }
APMenuItem >> submenu [
	^ submenu value
]

{ #category : #accessing }
APMenuItem >> submenu: anObject [
	submenu := anObject
]

{ #category : #'as yet unclassified' }
APMenuItem >> value [

	^value
]

{ #category : #'as yet unclassified' }
APMenuItem >> value: aValue [

	value := aValue
]
