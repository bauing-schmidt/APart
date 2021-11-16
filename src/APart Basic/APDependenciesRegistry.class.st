Class {
	#name : #APDependenciesRegistry,
	#superclass : #Object,
	#instVars : [
		'records'
	],
	#classVars : [
		'SettersDict'
	],
	#category : #'APart Basic-Core'
}

{ #category : #initialization }
APDependenciesRegistry >> addDependencyFrom: aPart aspect: anAspect to: path [ 

	^ records add: (APDependenciesRegistryRecord for: aPart aspect: anAspect path: path)
]

{ #category : #initialization }
APDependenciesRegistry >> addRawDependencyFrom: aPart aspect: anAspect to: path [ 

	^ (self addDependencyFrom: aPart aspect: anAspect to: path)
		raw: true;
		yourself
]

{ #category : #initialization }
APDependenciesRegistry >> backwardDependantsOf: aPart aspect: anAspect [

	^ (records 
		collect: [ :aRecord | aRecord target -> aRecord ]
		thenSelect: [ :association | 
			| aTarget aRecord |
			aTarget := association key.
			aRecord := association value.
			aPart = aTarget and: [ (aRecord targetAspect = anAspect) and: [ aTarget partInterface description knows: aRecord targetAspect ] ]
			  ]) collect: [ :association |
					association value "record" part -> association value "record" aspect ]
]

{ #category : #initialization }
APDependenciesRegistry >> dependantsOf: aPart aspect: anAspect [

	^ (self dependentAspectsOf: aPart aspect: anAspect) collect: #key
]

{ #category : #initialization }
APDependenciesRegistry >> dependentAspectsOf: aPart aspect: anAspect [

	| partAspectAssociations |
	partAspectAssociations := self forwardDependantsOf: aPart aspect: anAspect.
	partAspectAssociations addAll: (self backwardDependantsOf: aPart aspect: anAspect).
	^ partAspectAssociations
]

{ #category : #initialization }
APDependenciesRegistry >> forwardDependantsOf: aPart aspect: anAspect [

	^ (records 
		select: [ :aRecord | aRecord part = aPart and: [ aRecord aspect = anAspect ] ]
		thenCollect: [ :aRecord | aRecord target -> aRecord targetAspect ])
		 select: [ :association | association key value partInterface hasAspectNamed: association value ]
]

{ #category : #initialization }
APDependenciesRegistry >> initialize [

	super initialize.
	
	records := OrderedCollection new.
]
