"
APartExample ist die Basisklasse für alle Beispiel-Part-Klassen. Sie enthält keine wichtige Funktionalität, sondern dient dazu, den Baum von Subklassen unter APart zu entkoppeln.

"
Class {
	#name : #APartExample,
	#superclass : #APart,
	#instVars : [
		'shallLiveWithoutClients'
	],
	#category : #'APart Examples-Support'
}

{ #category : #'Example API' }
APartExample class >> canStartStandalone [

	^true
]

{ #category : #'initialize-release' }
APartExample >> initializeValues [

	shallLiveWithoutClients := false.
	super initializeValues.
]

{ #category : #'API testing' }
APartExample >> shallLiveWithoutClients [

	^shallLiveWithoutClients == true
]

{ #category : #accessing }
APartExample >> shallLiveWithoutClients: anObject [

	shallLiveWithoutClients := anObject
]
