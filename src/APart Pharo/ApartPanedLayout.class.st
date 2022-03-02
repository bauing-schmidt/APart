Class {
	#name : #APartPanedLayout,
	#superclass : #SpPanedLayout,
	#instVars : [
		'initialPosition'
	],
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartPanedLayout >> adapterName [

	^ #APartPanedAdapter
]

{ #category : #accessing }
APartPanedLayout >> initialPosition [

	^ initialPosition
]

{ #category : #accessing }
APartPanedLayout >> initialPosition: anObject [

	initialPosition := anObject
]

{ #category : #accessing }
APartPanedLayout >> setPositionDeferred: aNumber to: aWidget [
	
	"do nothing, the initial position is set explicitly"
]
