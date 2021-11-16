"
The following comment was copied from the original comments of APInterfaceListAspectBuilder

==========================================================

APInterfaceListAspectBuilder ist die spezielle Builder-Klasse für Subklassen von APartList.
"
Class {
	#name : #APInterfaceSteppedSliderAspectBuilder,
	#superclass : #APInterfaceAspectBuilder,
	#category : #'APart BasicParts'
}

{ #category : #API }
APInterfaceSteppedSliderAspectBuilder >> postBuildComponentKey: aSteppedSliderKey in: aView [

	self partKey = aSteppedSliderKey
		ifTrue: [self updateSteppedSliderRangeFor: aSteppedSliderKey in: aView]
]

{ #category : #API }
APInterfaceSteppedSliderAspectBuilder >> updateSteppedSliderRangeFor: aSteppedSliderKey in: aView [

	| clientsToUpdate |
	clientsToUpdate := aView notNil
				ifTrue: [IdentitySet with: aView]
				ifFalse: [IdentitySet withAll: self registeredClients].
	clientsToUpdate do: 
			[:client |
			client
				sliderStart: self part start
				stop: self part stop
				step: self part step
				forSteppedSliderKey: aSteppedSliderKey]
]
