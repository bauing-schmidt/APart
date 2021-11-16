Class {
	#name : #APDependenciesRegistryRecord,
	#superclass : #Object,
	#instVars : [
		'part',
		'aspect',
		'path',
		'raw'
	],
	#classVars : [
		'SettersDict'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'as yet unclassified' }
APDependenciesRegistryRecord class >> for: aPart aspect: anAspect path: aPath [

	^ self new
		part: aPart;
		aspect: anAspect;
		path: aPath;
		yourself
]

{ #category : #accessing }
APDependenciesRegistryRecord >> aspect [
	^ aspect
]

{ #category : #accessing }
APDependenciesRegistryRecord >> aspect: anObject [
	aspect := anObject
]

{ #category : #accessing }
APDependenciesRegistryRecord >> initialize [ 
	
	super initialize.
	
	raw := false.
]

{ #category : #testing }
APDependenciesRegistryRecord >> isRaw [

	^ raw
]

{ #category : #accessing }
APDependenciesRegistryRecord >> part [
	^ part
]

{ #category : #accessing }
APDependenciesRegistryRecord >> part: anObject [
	part := anObject
]

{ #category : #accessing }
APDependenciesRegistryRecord >> path [
	^ path
]

{ #category : #accessing }
APDependenciesRegistryRecord >> path: anObject [
	path := anObject
]

{ #category : #accessing }
APDependenciesRegistryRecord >> raw: anObject [
	raw := anObject
]

{ #category : #accessing }
APDependenciesRegistryRecord >> target [ 

	^ (part walkPath: path) key
]

{ #category : #accessing }
APDependenciesRegistryRecord >> targetAspect [

	^ path last
]
