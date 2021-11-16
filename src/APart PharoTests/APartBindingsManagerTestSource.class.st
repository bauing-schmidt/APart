Class {
	#name : #APartBindingsManagerTestSource,
	#superclass : #Object,
	#instVars : [
		'aspects'
	],
	#category : #'APart PharoTests'
}

{ #category : #initialization }
APartBindingsManagerTestSource >> aspectFor: anAspect [

	^ (aspects at: anAspect ifAbsent: [ nil ])
]

{ #category : #initialization }
APartBindingsManagerTestSource >> initialize [

	super initialize.
	aspects := Dictionary new.

]
