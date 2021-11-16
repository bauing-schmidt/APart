"
APxPathAndRedirectionSubPartL2ManualAspect an inherited example part, showing the required definitions when setting autoAspectDefinition to false.

"
Class {
	#name : #APxPathAndRedirectionSubPartL2ManualAspect,
	#superclass : #APxPathAndRedirectionSubPartL2,
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL2ManualAspect >> defineAspects [

	super defineAspects.
	partInterface description createAspectNamed: #enabled.
	partInterface description createAspectNamed: #attachedObject.
]
