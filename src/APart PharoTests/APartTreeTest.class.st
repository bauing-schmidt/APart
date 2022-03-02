Class {
	#name : #APartTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'part',
		'subpart1',
		'subpart2'
	],
	#category : #'APart PharoTests'
}

{ #category : #tests }
APartTreeTest >> testOpenClientPrompt [

	"smoke test"
	| aPart app |
		
	app := APartSpecApplication new.
	app useBackend: #Mock.
	aPart := APxTreeExamplePart createWithClientRegistry.
	self shouldnt: [ 
		APxTreeExample openOnPart: aPart application: app.
	] raise: Error 
]
