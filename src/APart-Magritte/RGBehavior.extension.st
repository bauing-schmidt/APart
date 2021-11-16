Extension { #name : #RGBehavior }

{ #category : #'*APart-Magritte' }
RGBehavior >> dependsOn: anotherBehavior [

	(self allSuperclasses includes: anotherBehavior) ifTrue: [ ^ true ].
	
	((self withAllSuperclasses flatCollect: [:each | each traitComposition traits]) includes: anotherBehavior) ifTrue: [ ^ true ].
	
	^ false	
]

{ #category : #'*APart-Magritte' }
RGBehavior >> traitsDefinitions [
	| methodsToRemoveMap |
	methodsToRemoveMap := self propertyNamed: #methodsToRemoveFromTraitComposition ifAbsent: [ Dictionary new ].
	^ self traitComposition transformations
		collect: [ :trait | 
			methodsToRemoveMap
				at: trait name
				ifPresent: [ :methods | 
					String
						streamContents: [ :s | 
							s
								nextPutAll: trait asString;
								nextPutAll: ' - '.
							methods sorted printAsSelfEvaluatingFormOn: s ] ]
				ifAbsent: [ trait asString ] ].
	
	
]
