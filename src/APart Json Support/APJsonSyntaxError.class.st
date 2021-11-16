"
Spezielle Error-Klasse für Syntaxfehler im Json-String.


"
Class {
	#name : #APJsonSyntaxError,
	#superclass : #Error,
	#category : #'APart Json Support'
}

{ #category : #printing }
APJsonSyntaxError >> printOn: s [

	super printOn: s.
	s
		nextPut: $(;
		nextPutAll: messageText;
		nextPut: $)
]
