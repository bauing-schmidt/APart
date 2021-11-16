"
APxRedirectedActionExamplePart demonstriert:
- Anwendung von APartRedirectedAction (Verwendung von Aktionen aus Sub-Parts)
"
Class {
	#name : #APxRedirectedActionExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'citiesPart',
		'countriesPart',
		'citiesListEnabled',
		'countriesListEnabled'
	],
	#category : #'APart Examples-RedirectedAction'
}

{ #category : #accessing }
APxRedirectedActionExamplePart >> citiesListEnabled [

	^citiesListEnabled
]

{ #category : #accessing }
APxRedirectedActionExamplePart >> citiesListEnabled: anObject [

	citiesListEnabled := anObject.
	self changedAspectValue: #citiesListEnabled
]

{ #category : #accessing }
APxRedirectedActionExamplePart >> citiesPart [

	^citiesPart
]

{ #category : #accessing }
APxRedirectedActionExamplePart >> countriesListEnabled [

	^countriesListEnabled
]

{ #category : #accessing }
APxRedirectedActionExamplePart >> countriesListEnabled: anObject [

	countriesListEnabled := anObject.
	self changedAspectValue: #countriesListEnabled
]

{ #category : #accessing }
APxRedirectedActionExamplePart >> countriesPart [

	^countriesPart
]

{ #category : #'initialize-release' }
APxRedirectedActionExamplePart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(#citiesListEnabled #countriesListEnabled);
		createAspectNamed: #countriesList
			redirectTo: #(#countriesPart #thingsList #selectionInList);
		createAspectNamed: #citiesList
			redirectTo: #(#citiesPart #thingsList #selectionInList)
]

{ #category : #'initialize-release' }
APxRedirectedActionExamplePart >> initializeActions [

	partInterface description
		createAction: #removeCountry redirectTo: #(#countriesPart #removeSelection);
		createAction: #removeCity redirectTo: #(#citiesPart #removeSelection).
]

{ #category : #'initialize-release' }
APxRedirectedActionExamplePart >> initializeValues [

	super initializeValues.
	citiesListEnabled := true.
	countriesListEnabled := true.
	citiesPart := APxRedirectedActionSubPart onPart: self key: #citiesPart.
	citiesPart setList: #('Berlin' 'Hamburg' 'Munich').
	citiesPart setStatefulConditionOn: 
			(APCondition on: [citiesListEnabled] ifNot: #citiesListDisabled).
	countriesPart := APxRedirectedActionSubPart onPart: self key: #countriesPart.
	countriesPart setList: #('Germany' 'France' 'Belgium').
	countriesPart setStatefulConditionOn: 
			(APCondition on: [countriesListEnabled] ifNot: #countriesListDisabled).
			
]
