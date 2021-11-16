Class {
	#name : #APartBindingsManagerTestSource1,
	#superclass : #APartBindingsManagerTestSource,
	#category : #'APart PharoTests'
}

{ #category : #initialization }
APartBindingsManagerTestSource1 >> aspect1Message [

	^ 101
]

{ #category : #initialization }
APartBindingsManagerTestSource1 >> aspect2Message [

	^ 102
]

{ #category : #initialization }
APartBindingsManagerTestSource1 >> initialize [ 
	
	super initialize.
	
	aspects at: #aspect1 put: (APAspect named: #apect1 for: ((APAspectAdaptor forAspect: #aspect1Message) subject: self)).	
	aspects at: #aspect2 put: (APAspect named: #aspect2 for: ((APAspectAdaptor forAspect: #aspect2Message) subject: self)).
	aspects at: #aspect3 put: (APAspect named: #aspect3 for: APartBindingsManagerTestSource2 new).
]

{ #category : #initialization }
APartBindingsManagerTestSource1 >> sourceId [

	^ 1
]
