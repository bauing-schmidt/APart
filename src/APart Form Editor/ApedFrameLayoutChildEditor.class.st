"
I define a form for properties of children of a frame layout
"
Class {
	#name : #ApedFrameLayoutChildEditor,
	#superclass : #ApedLayoutChildEditor,
	#category : #'APart Form Editor-Layout Child Editors'
}

{ #category : #specs }
ApedFrameLayoutChildEditor class >> aspectPairs [

	^ super aspectPairs, {
	}

]

{ #category : #specs }
ApedFrameLayoutChildEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedFrameLayoutChildEditor class >> matchingPartClass [

	^ApedFrameLayoutChildPart
]
