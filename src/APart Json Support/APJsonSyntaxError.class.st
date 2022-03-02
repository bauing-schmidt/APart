"
Spezielle Error-Klasse für Syntaxfehler im Json-String.


"
Class {
	#name : #APJsonSyntaxError,
	#superclass : #Error,
	#instVars : [
		'filename'
	],
	#category : #'APart Json Support'
}

{ #category : #accessing }
APJsonSyntaxError >> filename [

	^ filename
]

{ #category : #accessing }
APJsonSyntaxError >> filename: anObject [

	filename := anObject
]
