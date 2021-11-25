"
Extension of a MessageSend to associate a send with a key name and modifier pattern.
To also represent some mouse events with modifiers, virtual key names are defined for the supported events, see class side.
"
Class {
	#name : #APRsEventMapping,
	#superclass : #MessageSend,
	#instVars : [
		'keyName',
		'commandKeyPressed',
		'controlKeyPressed',
		'optionKeyPressed',
		'shiftKeyPressed'
	],
	#category : #'APart Roassal Support-Support'
}

{ #category : #'instance creation' }
APRsEventMapping class >> mapControlKey: aKeyName to: aSelfSelector [
	"As we do not set a receiver, it is left as nil, which later is replaced by the dispatcher instance"
	
	^self new
		keyName: aKeyName;
		controlKeyPressed: true;
		selector: aSelfSelector;
		yourself
]

{ #category : #'instance creation' }
APRsEventMapping class >> mapKey: aKeyName to: aSelfSelector [
	"As we do not set a receiver, it is left as nil, which later is replaced by the dispatcher instance"
	
	^self new
		keyName: aKeyName;
		selector: aSelfSelector;
		yourself
]

{ #category : #'instance creation' }
APRsEventMapping class >> mapOptionKey: aKeyName to: aSelfSelector [
	"As we do not set a receiver, it is left as nil, which later is replaced by the dispatcher instance"
	
	^self new
		keyName: aKeyName;
		optionKeyPressed: true;
		selector: aSelfSelector;
		yourself
]

{ #category : #'instance creation' }
APRsEventMapping class >> mapShiftKey: aKeyName to: aSelfSelector [
	"As we do not set a receiver, it is left as nil, which later is replaced by the dispatcher instance"
	
	^self new
		keyName: aKeyName;
		shiftKeyPressed: true;
		selector: aSelfSelector;
		yourself
]

{ #category : #comparing }
APRsEventMapping >> = other [

	^ keyName = other keyName
		and: [ self modifierPattern = other modifierPattern]
]

{ #category : #accessing }
APRsEventMapping >> commandKeyPressed [

	^ commandKeyPressed
]

{ #category : #accessing }
APRsEventMapping >> commandKeyPressed: anObject [

	commandKeyPressed := anObject
]

{ #category : #accessing }
APRsEventMapping >> controlKeyPressed [

	^ controlKeyPressed
]

{ #category : #accessing }
APRsEventMapping >> controlKeyPressed: anObject [

	controlKeyPressed := anObject
]

{ #category : #comparing }
APRsEventMapping >> hash [

	^ keyName hash bitXor: self modifierPattern hash
]

{ #category : #initialization }
APRsEventMapping >> initialize [

	super initialize.
	commandKeyPressed := controlKeyPressed := optionKeyPressed := shiftKeyPressed := false.
]

{ #category : #accessing }
APRsEventMapping >> keyName [

	^ keyName
]

{ #category : #accessing }
APRsEventMapping >> keyName: anObject [

	keyName := anObject
]

{ #category : #API }
APRsEventMapping >> matchesModifiersIn: evt [

	^ shiftKeyPressed = evt shiftKeyPressed and: [
		controlKeyPressed = evt controlKeyPressed and: [
			optionKeyPressed = evt optionKeyPressed and: [
				commandKeyPressed = evt commandKeyPressed
			]
		]
	]
]

{ #category : #API }
APRsEventMapping >> modifierPattern [

	| s |
	s := String new: 4 withAll: $ .
	shiftKeyPressed ifTrue: [ s at: 1 put: $S ].
	controlKeyPressed ifTrue: [ s at: 2 put: $C ].
	optionKeyPressed ifTrue: [ s at: 3 put: $O ].
	commandKeyPressed ifTrue: [ s at: 4 put: $c ].
	^ s

]

{ #category : #accessing }
APRsEventMapping >> optionKeyPressed [

	^ optionKeyPressed
]

{ #category : #accessing }
APRsEventMapping >> optionKeyPressed: anObject [

	optionKeyPressed := anObject
]

{ #category : #accessing }
APRsEventMapping >> shiftKeyPressed [

	^ shiftKeyPressed
]

{ #category : #accessing }
APRsEventMapping >> shiftKeyPressed: anObject [

	shiftKeyPressed := anObject
]
