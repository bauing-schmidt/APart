"
APConditionFinal is a class that conforms to the APCondition protocol, but internally constructs an instance whenever the negative result of an APCondition is established.

--

DE:APConditionFinal ist eine Klasse, die dem APCondition-Protokoll entspricht, von der jedoch intern immer dann eine Instanz konstruiert wird, sobald das negative Ergebnis einer APCondition feststeht.
"
Class {
	#name : #APConditionFinal,
	#superclass : #APConditionBase,
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APConditionFinal class >> on: aSymbolOrMessageOrSomethingElse [

	^self new initOn: aSymbolOrMessageOrSomethingElse
]

{ #category : #API }
APConditionFinal >> & next [
	"An APConditionFinal as the first element of a chain is omitted if it is true. In the other case, no chain is created at all."
	"DE:Eine APConditionFinal als erstes Element einer Chain entfällt, sofern es true ist. Im anderen Fall entsteht überhaupt keine Chain."

	^reason == nil ifTrue: [next] ifFalse: [self].
]

{ #category : #API }
APConditionFinal >> asFinalCondition [

	^self
]

{ #category : #API }
APConditionFinal >> booleanValue [

	^reason == nil
]

{ #category : #API }
APConditionFinal >> initOn: aSymbolOrMessageOrSomethingElse [

	reason := aSymbolOrMessageOrSomethingElse.
]

{ #category : #API }
APConditionFinal >> isActive [
	"compatibility protocol"

	^self booleanValue
]

{ #category : #API }
APConditionFinal >> reason [
	"Only APConditionFinal may return the reason, as it does not represent a calculated status in a normal APCondition"
	"DE:Nur APConditionFinal darf den reason zurückgeben, da er bei einer gewöhnlichen APCondition keinen errechneten Status repräsentiert"

	^reason
]

{ #category : #API }
APConditionFinal >> reasonForInactivity [
	"compatibility protocol"
	"DE:Kompatibilitätsprotokoll"

	^self reason
]
