"
supporting part class for APartDescriptionTest
"
Class {
	#name : #APartDescriptionTestPart,
	#superclass : #APart,
	#instVars : [
		'autoAspects',
		'state'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #accessing }
APartDescriptionTestPart >> autoAspectDefinition [

	^ autoAspects
]

{ #category : #accessing }
APartDescriptionTestPart >> autoAspects [
	^ autoAspects
]

{ #category : #accessing }
APartDescriptionTestPart >> autoAspects: anObject [
	autoAspects := anObject
]

{ #category : #accessing }
APartDescriptionTestPart >> defineAspects [ 

	self description createAspectNamed: #explicitAspect
]

{ #category : #accessing }
APartDescriptionTestPart >> explicitAspect [

	^ 42
]

{ #category : #accessing }
APartDescriptionTestPart >> initialize [

	super initialize.
	autoAspects := super autoAspectDefinition.
]

{ #category : #accessing }
APartDescriptionTestPart >> state [

	^ state
]

{ #category : #accessing }
APartDescriptionTestPart >> state: anObject [

	state := anObject
]
