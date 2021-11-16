"
SUTAPAbstractInteractionPrinter ist die abstrakte Basisklasse für konkrete InteractionPrinter-Klassen.

Subclasses must implement the following messages:
	Subclass responsibility
		printExpressionForInteractions:states:
		printInteractions:


"
Class {
	#name : #SUTAPAbstractInteractionPrinter,
	#superclass : #Object,
	#instVars : [
		'ws',
		'indent',
		'hasReceiverInCascade'
	],
	#category : #'APart Tests'
}

{ #category : #'instance creation' }
SUTAPAbstractInteractionPrinter class >> newEmpty [

	^self on: (WriteStream on: String new) indent: 0
]

{ #category : #'instance creation' }
SUTAPAbstractInteractionPrinter class >> newEmptyIndent: newIndent [

	^self on: (WriteStream on: String new) indent: newIndent
]

{ #category : #'instance creation' }
SUTAPAbstractInteractionPrinter class >> on: aWriteStream indent: anIndentCount [

	^self new initOn: aWriteStream indent: anIndentCount
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> basicPrintSend: oneArgSelector with: arg1String [

	ws
		nextPutAll: oneArgSelector;
		space;
		nextPutAll: arg1String
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> basicPrintSend: twoArgsSelector with: arg1String with: arg2String [

	| keywords |
	keywords := twoArgsSelector keywords.
	ws
		nextPutAll: keywords first;
		space;
		nextPutAll: arg1String;
		space;
		nextPutAll: keywords last;
		space;
		nextPutAll: arg2String
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> basicPrintSend: threeArgsSelector with: arg1String with: arg2String with: arg3String [

	| keywords |
	keywords := threeArgsSelector keywords.
	ws
		nextPutAll: keywords first;
		space;
		nextPutAll: arg1String;
		space;
		nextPutAll: (keywords at: 2);
		space;
		nextPutAll: arg2String;
		space;
		nextPutAll: keywords last;
		space;
		nextPutAll: arg3String
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> basicPrintStringFor: obj [

	^obj printString
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> clone [

	^self class on: ws indent: indent
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> clonePlus: additionalIndent [

	^self class on: ws indent: indent + additionalIndent
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> cloneWithReceiverInCascade [

	^(self class on: ws indent: indent)
		hasReceiverInCascade: hasReceiverInCascade;
		yourself
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> cloneWithoutIndent [

	^self class on: ws indent: 0
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> commentedString: aString [

	| s |
	s := WriteStream on: (String new: aString size + 2).
	s nextPut: $".
	aString do: 
			[:c |
			s nextPut: c.
			c = $" ifTrue: [s nextPut: c]].
	s nextPut: $".
	^s contents
]

{ #category : #API }
SUTAPAbstractInteractionPrinter >> hasReceiverInCascade [

	^hasReceiverInCascade
]

{ #category : #API }
SUTAPAbstractInteractionPrinter >> hasReceiverInCascade: aBoolean [

	hasReceiverInCascade := aBoolean
]

{ #category : #'initialize-release' }
SUTAPAbstractInteractionPrinter >> initOn: aWriteStream indent: anIndentCount [

	ws := aWriteStream.
	indent := anIndentCount.
	hasReceiverInCascade := false.
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> interactionWithCommentString [

	| text |
	text := ws contents.
	text notEmpty
		ifTrue: [text first = $" ifFalse: [text := '"' , text , '"']].
	^APRecordedInteraction special: #comment value: text
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> nextInteractionChunkFrom: rs [
	"Jeder Eintrag, der individuelle expectedStates aufweist, beendet einen Chunk"

	| nextChunk |
	nextChunk := OrderedCollection new.
	[rs atEnd] whileFalse: 
			[nextChunk add: rs next.
			nextChunk last expectedStates notNil ifTrue: [^nextChunk]].
	^nextChunk
]

{ #category : #API }
SUTAPAbstractInteractionPrinter >> printCodeForInteractions: interactionSequence [

	| rs nextChunk |
	rs := interactionSequence readStream.
	
	[nextChunk := self nextInteractionChunkFrom: rs.
	nextChunk notEmpty]
			whileTrue: 
				[nextChunk last expectedStates
					ifNotNil: 
						[:states |
						self printExpressionForInteractions: nextChunk states: states ]
					ifNil: [self printInteractions: nextChunk ]]
]

{ #category : #API }
SUTAPAbstractInteractionPrinter >> printCodeForInteractions: interactionSequence head: aHeading tail: aTailing [

	ws nextPutAll: aHeading.
	self printCodeForInteractions: interactionSequence.
	ws nextPutAll: aTailing
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> printCommentLine: line [

	self printIndent.
	ws
		nextPutAll: (self commentedString: line);
		cr
]

{ #category : #API }
SUTAPAbstractInteractionPrinter >> printException: anException [
	"This point is achieved if an exception was caused by the CodePrinter itself."

	| errorMsg |
	errorMsg := 'An error occured while printing recorded interactions: '
				, anException messageText.
	self printCommentLine: errorMsg.
]

{ #category : #'Subclass responsibility' }
SUTAPAbstractInteractionPrinter >> printExpressionForInteractions: interactions states: expectedStates [

	self subclassResponsibility
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> printIndent [

	indent timesRepeat: [ws tab]
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> printIndentPlus: extra [

	indent + extra timesRepeat: [ws tab]
]

{ #category : #'Subclass responsibility' }
SUTAPAbstractInteractionPrinter >> printInteractions: interactions [

	self subclassResponsibility
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> printLine: lineString [

	self printIndent.
	ws
		nextPutAll: lineString;
		cr
]

{ #category : #printing }
SUTAPAbstractInteractionPrinter >> printOn: s [

	super printOn: s.
	s
		nextPut: $(;
		nextPutAll: 'i: ';
		nextPutAll: indent printString;
		nextPutAll: ', cascade: ';
		nextPutAll: hasReceiverInCascade printString;
		nextPut: $)
]

{ #category : #private }
SUTAPAbstractInteractionPrinter >> receiverString [

	^'self'
]

{ #category : #API }
SUTAPAbstractInteractionPrinter >> resultString [

	^ws ifNotNil: [ws contents]
]
