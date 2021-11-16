Class {
	#name : #APartBindingsManagerTest,
	#superclass : #TestCase,
	#instVars : [
		'manager'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartBindingsManagerTest >> setUp [ 
	
	super setUp.
	
	manager := APartBindingsManager new.
	
	
	
]

{ #category : #running }
APartBindingsManagerTest >> testAspectFromSource [

	manager source: APartBindingsManagerTestSource1 new.

	self assert: (manager aspectAt: #aspect1) value equals: 101.	
	self assert: (manager aspectAt: #aspect2) value equals: 102.
	self assert: (manager aspectAt: #aspect3) value sourceId equals: 2.

	

]

{ #category : #running }
APartBindingsManagerTest >> testCompositeKey [

	| adaptor |

	manager source: APartBindingsManagerTestSource1 new.

	adaptor := manager aspectAt: #'aspect3 aspect2'.

	self assert: adaptor value equals: 202.

	

]

{ #category : #running }
APartBindingsManagerTest >> testCompositeKeyStoresBinding [

	| adaptor |

	manager source: APartBindingsManagerTestSource1 new.

	adaptor := manager aspectAt: #'aspect3 aspect2'.

	self assert: (manager bindings at: #aspect3) value sourceId equals: 2.

	

]

{ #category : #running }
APartBindingsManagerTest >> testNoSource [

	self assert: (manager aspectAt: #aspect1) isNil.	
	self assert: (manager aspectAt: #aspect2) isNil.
	self assert: (manager aspectAt: #aspect3) isNil.
	self assert: (manager aspectAt: #aspect4) isNil.
	

]

{ #category : #running }
APartBindingsManagerTest >> testNoSourceWithInstalledAspect [

	manager aspectAt: #aspect5 put: (APAspect named: #aspect5 for: 105).

	self assert: (manager aspectAt: #aspect1) isNil.	
	self assert: (manager aspectAt: #aspect2) isNil.
	self assert: (manager aspectAt: #aspect3) isNil.
	self assert: (manager aspectAt: #aspect4) isNil.
	self assert: (manager aspectAt: #aspect5) value equals: 105.
	

]
