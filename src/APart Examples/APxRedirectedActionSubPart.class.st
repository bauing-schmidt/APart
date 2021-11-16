"
APxRedirectedActionSubPart ist ein mehrfach verwendeter Sub-Part für das Beispiel APxRedirectedActionExamplePart
"
Class {
	#name : #APxRedirectedActionSubPart,
	#superclass : #APartExample,
	#instVars : [
		'thingsList'
	],
	#category : #'APart Examples-RedirectedAction'
}

{ #category : #'Generic obsolete API' }
APxRedirectedActionSubPart >> extraAnnouncements [

	^Array with: #removedSomething:announcer: -> APxTestAnnouncement
]

{ #category : #'initialize-release' }
APxRedirectedActionSubPart >> initializeActions [

	partInterface description
		createAction: #removeSelection
		do: 
			[| removed |
			removed := thingsList list remove: thingsList selection.
			self announcer announcer announce: ((APxTestAnnouncement new)
						what: removed;
						flag: key;
						yourself)]
		if: (APCondition on: [thingsList selection notNil] ifNot: #nothingSelected)
]

{ #category : #'initialize-release' }
APxRedirectedActionSubPart >> initializeValues [

	super initializeValues.
	thingsList := APartList onPart: self key: #thingsList.
	thingsList trigger: #selectionChanged do: [self rootUpdate].
	thingsList setStatefulConditionOn: (APCondition on: [self isActive]
				ifNot: #parentIsInactive)
]

{ #category : #accessing }
APxRedirectedActionSubPart >> setList: aCollection [

	thingsList list: aCollection asOrderedCollectionWithDependants.
]

{ #category : #accessing }
APxRedirectedActionSubPart >> thingsList [

	^thingsList
]
