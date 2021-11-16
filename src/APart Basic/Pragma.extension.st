Extension { #name : #Pragma }

{ #category : #'*APart Basic' }
Pragma class >> allNamed: aSymbol under: parentClass [
	"Answer a collection of all pragmas found in methods of all subclasses whose keyword is equal to the first argument
	[Pragma allNamed: #pragmas: under: Object class ]"

	^ APartPlatform current allPragmasNamed: aSymbol under: parentClass
]
