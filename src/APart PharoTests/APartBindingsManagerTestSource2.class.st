Class {
	#name : #APartBindingsManagerTestSource2,
	#superclass : #APartBindingsManagerTestSource,
	#category : #'APart PharoTests'
}

{ #category : #initialization }
APartBindingsManagerTestSource2 >> aspect1 [

	^ aspects at: #aspect1
]

{ #category : #initialization }
APartBindingsManagerTestSource2 >> aspect1Message [

	^ 201

]

{ #category : #initialization }
APartBindingsManagerTestSource2 >> aspect2 [

	^ aspects at: #aspect2
]

{ #category : #initialization }
APartBindingsManagerTestSource2 >> aspect2Message [

	^ 202

]

{ #category : #initialization }
APartBindingsManagerTestSource2 >> initialize [

	super initialize.
	
	aspects at: #aspect1 put: 201.	
	aspects at: #aspect2 put: 202.

]

{ #category : #initialization }
APartBindingsManagerTestSource2 >> sourceId [

	^ 2
]
