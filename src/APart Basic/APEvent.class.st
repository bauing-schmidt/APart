Class {
	#name : #APEvent,
	#superclass : #Object,
	#instVars : [
		'processedByChild',
		'causingEvent',
		'interface'
	],
	#category : #'APart Basic-Events'
}

{ #category : #'instance creation' }
APEvent class >> from: causingEvent interface: anInterface [

	^ self new 
		causingEvent: causingEvent;
		interface: anInterface;
		yourself
]

{ #category : #accessing }
APEvent >> causingEvent [
	^ causingEvent
]

{ #category : #accessing }
APEvent >> causingEvent: anObject [
	causingEvent := anObject
]

{ #category : #accessing }
APEvent >> initialize [

	super initialize.
	
	processedByChild := false
]

{ #category : #accessing }
APEvent >> interface [
	^ interface
]

{ #category : #accessing }
APEvent >> interface: anObject [
	interface := anObject
]

{ #category : #accessing }
APEvent >> processedByChild [
	^ processedByChild
]

{ #category : #accessing }
APEvent >> processedByChild: anObject [
	processedByChild := anObject
]
