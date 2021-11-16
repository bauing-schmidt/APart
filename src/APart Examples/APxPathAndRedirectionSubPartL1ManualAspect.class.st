"
APxPathAndRedirectionSubPartL1ManualAspect an inherited example part, showing the required definitions when setting autoAspectDefinition to false.

"
Class {
	#name : #APxPathAndRedirectionSubPartL1ManualAspect,
	#superclass : #APxPathAndRedirectionSubPartL1,
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL1ManualAspect >> defineAspects [

	super defineAspects.
	partInterface description createAspectNamed: #attachedObject.
	partInterface description createAspectNamed: #partL2.
	partInterface description createAspectNamed: #enabled.
]
