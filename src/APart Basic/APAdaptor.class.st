Class {
	#name : #APAdaptor,
	#superclass : #APModelWithValue,
	#instVars : [
		'model',
		'getBlock',
		'setBlock',
		'updateBlock'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APAdaptor class >> on: aModel [
	^self new model: aModel
]

{ #category : #dependents }
APAdaptor >> addDependent: aDependent [ 

	dependents isNil ifTrue: [model addDependent: self].
	super addDependent: aDependent.
]

{ #category : #dependents }
APAdaptor >> getBlock: aBlock [
	getBlock := aBlock.
]

{ #category : #dependents }
APAdaptor >> initialize [
	super initialize.

	self
		getBlock: [:m | m value];
		setBlock: [:m :v | m value: v];
		updateBlock: [:m :a :p | a == #value]
]

{ #category : #dependents }
APAdaptor >> isAPAdaptor [

	^true
]

{ #category : #dependents }
APAdaptor >> model [

	^model
]

{ #category : #dependents }
APAdaptor >> model: aModel [
	model removeDependent: self.
	model := aModel.
	dependents notNil ifTrue: [model addDependent: self]
]

{ #category : #dependents }
APAdaptor >> performAction: aSelector [

	self
		getBlock: [:m | false];
		setBlock: [:m :v | m perform: aSelector];
		updateBlock: [:m :a :p | false]
]

{ #category : #dependents }
APAdaptor >> removeDependent: aDependent [ 

	super removeDependent: aDependent.
	dependents isNil ifTrue: [model removeDependent: self]
]

{ #category : #dependents }
APAdaptor >> setBlock: aBlock [

	setBlock := aBlock

]

{ #category : #dependents }
APAdaptor >> setValue: newValue [
	setBlock value: model value: newValue
]

{ #category : #dependents }
APAdaptor >> subject [
	^model value
]

{ #category : #dependents }
APAdaptor >> subjectChannel: aValueHolder [

	self model: aValueHolder
]

{ #category : #dependents }
APAdaptor >> update: aspect with: parameter from: sender [

	(updateBlock value: model value: aspect value: parameter)
		ifTrue: [self changed: #value]
]

{ #category : #dependents }
APAdaptor >> updateBlock: aBlock [

	updateBlock := aBlock
]

{ #category : #dependents }
APAdaptor >> value [
	^getBlock value: model
]

{ #category : #dependents }
APAdaptor >> valueUsingSubject: aSubject [

	aSubject == nil ifTrue: [^nil].
	^getBlock value: aSubject
]
