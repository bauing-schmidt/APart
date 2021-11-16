"
Description
--------------------

I represent a change that would create a package during a Famix generation.

Examples
--------------------

	FmxPackageAddition named: 'Famix-Example-Entities'
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	packageName:		<aString>		Name of the package to create.
"
Class {
	#name : #APMaPackageAddition,
	#superclass : #APMaCodeChange,
	#instVars : [
		'packageName'
	],
	#category : #'APart-Magritte'
}

{ #category : #'instance creation' }
APMaPackageAddition class >> named: aName [
	^ self new
		packageName: aName;
		yourself
]

{ #category : #accessing }
APMaPackageAddition >> apply [
	RPackageOrganizer default createPackageNamed: self packageName
]

{ #category : #accessing }
APMaPackageAddition >> packageName [ 

	^ packageName
]

{ #category : #initialization }
APMaPackageAddition >> packageName: aPackageName [
	packageName := aPackageName
]
