"
SUTAPInteractionPrinter implementiert eine Variante für das Drucken von APRecordedInteraction-Objekten als Programmcode für UnitTests.
"
Class {
	#name : #SUTAPInteractionPrinter,
	#superclass : #SUTAPAbstractInteractionPrinter,
	#category : #'APart Tests'
}

{ #category : #private }
SUTAPInteractionPrinter >> appendConverted: subInteraction to: printableColl [

	subInteraction type = #valueChange
		ifTrue: 
			[self basicPrintInteractionValue: subInteraction.
			^printableColl add: self interactionWithCommentString].
	subInteraction type = #action
		ifTrue: 
			[self basicPrintAction: subInteraction.
			^printableColl add: self interactionWithCommentString].
	subInteraction type = #trigger
		ifTrue: 
			[subInteraction value
				ifNotNil: 
					[:actor |
					self basicPrintTriggerOperator: actor.
					^printableColl add: self interactionWithCommentString].
			subInteraction subInteractionsOrNil
				ifNotNil: [:subSubs | subSubs do: [:si | self class newEmpty appendConverted: si to: printableColl]].
			^self].
	printableColl add: subInteraction
]

{ #category : #private }
SUTAPInteractionPrinter >> basicPrintAction: interaction [

	ws
		nextPutAll: #execute:;
		space;
		nextPutAll: interaction key printString.
	interaction value
		ifNotNil: 
			[:actionArg |
			ws
				nextPutAll: ' with: ';
				nextPutAll: actionArg printString]
]

{ #category : #private }
SUTAPInteractionPrinter >> basicPrintAction: interaction needsSubBlock: needsSubBlock [

	| actionKey actionArg |
	interaction type = #trigger
		ifTrue: 
			[^self
				basicPrintSend: #forTrigger:prepare:
				with: interaction key printString
				with: '['].
	actionKey := interaction key printString.
	actionArg := interaction value.
	(actionArg isNil and: [needsSubBlock not])
		ifTrue: [^self basicPrintSend: #execute: with: actionKey].
	(actionArg isNil and: [needsSubBlock])
		ifTrue: [^self basicPrintSend: #execute:preparing: with: actionKey with: '['].
	(actionArg notNil and: [needsSubBlock not])
		ifTrue: 
			[^self
				basicPrintSend: #execute:with:
				with: actionKey
				with: actionArg printString].
	^self
		basicPrintSend: #execute:with:preparing:
		with: actionKey
		with: actionArg printString
		with: '['
]

{ #category : #private }
SUTAPInteractionPrinter >> basicPrintInteractionValue: interaction [

	| willNotBeExecutable |
	willNotBeExecutable := interaction key includes: $ .
	willNotBeExecutable ifTrue: [ws nextPut: $"].
	self
		basicPrintSend: #setAspect:value:
		with: interaction key printString
		with: (self basicPrintStringFor: interaction value).
	willNotBeExecutable
		ifTrue: 
			[ws
				nextPut: $";
				cr.
			^0].
	^1
]

{ #category : #private }
SUTAPInteractionPrinter >> basicPrintTriggerOperator: operator [

	ws
		nextPutAll: #callOperator:;
		space.
	operator printConstructorOn: ws
]

{ #category : #private }
SUTAPInteractionPrinter >> hasOtherThanCommentIn: interactions behind: index [

	index + 1 to: interactions size
		do: 
			[:i |
			| ia |
			ia := interactions at: i.
			(ia type = #special and: [ia key = #comment]) ifFalse: [^true]].
	^false
]

{ #category : #private }
SUTAPInteractionPrinter >> headingForComplexPromptNamed: aPromptKey [

	indent timesRepeat: [ws tab].
	self
		basicPrintSend: #inPrompt:do:
		with: aPromptKey printString
		with: '['.
	ws cr.
	^ws contents
]

{ #category : #'Subclass responsibility' }
SUTAPInteractionPrinter >> printActionFor: interaction [
	"Gibt immer 0 zurück, weil Ende von Zeilen und Statements selbst gesetzt wird."

	(interaction type = #trigger and: [interaction subInteractionsOrNil isNil])
		ifTrue: 
			[self printLine: '"' , ('Trigger: ' , interaction key printString) , '"'.
			^0].
	self printIndent.
	hasReceiverInCascade
		ifFalse: 
			[self printLine: self receiverString.
			hasReceiverInCascade := true].
	interaction subInteractionsOrNil
		ifNil: 
			[self basicPrintAction: interaction needsSubBlock: false.
			ws
				nextPut: $.;
				cr.
			hasReceiverInCascade := false]
		ifNotNil: 
			[:subInteractions |
			| convertedInteractions needsSubBlock |
			convertedInteractions := OrderedCollection new.
			subInteractions
				do: [:si | self class newEmpty appendConverted: si to: convertedInteractions].
			needsSubBlock := convertedInteractions contains: [:ia | ia isComment not].
			self basicPrintAction: interaction needsSubBlock: needsSubBlock.
			needsSubBlock
				ifFalse: 
					[ws nextPut: $..
					hasReceiverInCascade := false].
			ws cr.
			(self clonePlus: 1) printInteractions: convertedInteractions.
			needsSubBlock
				ifTrue: 
					[ws cr.
					self printLine: ']. 	"End of ' , interaction key printString , '"'.
					hasReceiverInCascade := false]].
	^0
]

{ #category : #private }
SUTAPInteractionPrinter >> printComplexPrompt: interaction [

	(self clonePlus: 1)
		printCodeForInteractions: interaction subInteractions
		head: ((self class newEmptyIndent: indent)
				headingForComplexPromptNamed: interaction key)
		tail: (self class newEmptyIndent: indent) tailingForComplexPrompt.
	^0
]

{ #category : #'Subclass responsibility' }
SUTAPInteractionPrinter >> printExpressionForInteractions: interactions states: expectedStates [

	self printLine: self receiverString.
	hasReceiverInCascade := true.
	indent := indent + 1.
	self printLine: #afterDoing:expectStates: keywords first , ' ['.
	(self clonePlus: 1) printInteractions: interactions.
	self printLine: ']'.
	self printLine: #afterDoing:expectStates: keywords last , ' ['.
	expectedStates
		printAsTestExpressionOn: ws
		indent: indent + 1
		receiverString: expectedStates class name asString.
	indent := indent - 1.
	self printLine: '].'
]

{ #category : #'Subclass responsibility' }
SUTAPInteractionPrinter >> printInteraction: interaction [

	| t |
	t := interaction type.
	t = #special ifTrue: [^self printSpecialFor: interaction].
	hasReceiverInCascade
		ifFalse: 
			[self printLine: self receiverString.
			hasReceiverInCascade := true.
			indent := indent + 1].
	t = #trigger ifTrue: [^self printTrigger: interaction].
	t = #valueChange ifTrue: [^self printValueFor: interaction].
	t = #action
		ifTrue: 
			[self cloneWithReceiverInCascade printActionFor: interaction.
			hasReceiverInCascade := false.
			indent := indent - 1.
			^0].
	t = #simplePrompt ifTrue: [^self printSimplePrompt: interaction].
	t = #complexPrompt ifTrue: [^self printComplexPrompt: interaction].
	self printCommentLine: 'Unknown type ' , t printString.
	^0
]

{ #category : #'Subclass responsibility' }
SUTAPInteractionPrinter >> printInteractions: interactions [

	| printedCount |
	printedCount := 0.
	interactions doWithIndex: 
			[:interaction :i |
			| subPrintCount |
			subPrintCount := self printInteraction: interaction.
			printedCount := printedCount + subPrintCount.
			((interaction isSpecial: #comment) or: [subPrintCount = 0])
				ifFalse: 
					[(i < interactions size
						and: [self hasOtherThanCommentIn: interactions behind: i])
							ifTrue: [ws nextPut: $;]
							ifFalse: 
								[ws nextPut: $..
								hasReceiverInCascade := false]].
			subPrintCount > 0 ifTrue: [ws cr]].
	^printedCount
]

{ #category : #private }
SUTAPInteractionPrinter >> printSimplePrompt: interaction [

	| pr |
	self printIndent.
	ws
		nextPutAll: #preparePromptResult:;
		space.
	pr := interaction value.
	pr value notNil ifTrue: [ws nextPut: $(].
	ws
		nextPut: $(;
		nextPutAll: pr class name;
		space.
	self
		basicPrintSend: #controllingFor:trigger:
		with: pr promptKey printString
		with: pr promptClosingTriggerKey printString.
	ws nextPut: $).
	pr value
		ifNotNil: 
			[:v |
			ws cr.
			self printIndentPlus: 3.
			ws
				space;
				nextPutAll: #value:;
				space;
				nextPutAll: (self basicPrintStringFor: v);
				nextPutAll: '; yourself)'].
	^1
]

{ #category : #private }
SUTAPInteractionPrinter >> printSpecialFor: anInteraction [

	| k |
	k := anInteraction key.
	(k = #printString or: [k = #comment])
		ifTrue: 
			[self printIndent.
			ws nextPutAll: anInteraction value.
			^1].
	^0
]

{ #category : #private }
SUTAPInteractionPrinter >> printTrigger: interaction [

	interaction value
		ifNotNil: 
			[:operator |
			self printIndent.
			self basicPrintTriggerOperator: operator.
			^1]
		ifNil: 
			[interaction subInteractionsOrNil notNil
				ifTrue: 
					[self printActionFor: interaction.
					hasReceiverInCascade := false.
					indent := indent - 1]].
	^0
]

{ #category : #private }
SUTAPInteractionPrinter >> printValueFor: interaction [

	self printIndent.
	^self basicPrintInteractionValue: interaction
]

{ #category : #private }
SUTAPInteractionPrinter >> tailingForComplexPrompt [

	indent timesRepeat: [ws tab].
	ws
		nextPutAll: ']. 	';
		nextPutAll: (self commentedString: 'Prompt closed');
		cr.
	^ws contents
]
