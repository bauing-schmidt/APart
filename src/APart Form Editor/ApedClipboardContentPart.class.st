Class {
	#name : #ApedClipboardContentPart,
	#superclass : #APart,
	#instVars : [
		'elements',
		'layouts',
		'elementIDsEnumeration',
		'cutContent'
	],
	#category : #'APart Form Editor-Support'
}

{ #category : #accessing }
ApedClipboardContentPart >> elementIDsEnumeration [
	^ elementIDsEnumeration
]

{ #category : #accessing }
ApedClipboardContentPart >> elementIDsEnumeration: anObject [
	elementIDsEnumeration := anObject
]

{ #category : #accessing }
ApedClipboardContentPart >> elements [
	^ elements
]

{ #category : #accessing }
ApedClipboardContentPart >> elements: anObject [
	elements := anObject
]

{ #category : #accessing }
ApedClipboardContentPart >> initOnJson: aJsonObj [ 
	
	| elmJson layoutsJson |	
		
	elmJson := (aJsonObj at: #elements ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	elements := elmJson collect: [ :each | 
		ApedPresenterPart onPart: self key:  UUID new onJson: each ].

	layoutsJson := (aJsonObj at: #layouts ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	layouts := layoutsJson collect: [ :each | 
		ApedLayoutPart onPart: self key:  UUID new onJson: each ].


]

{ #category : #accessing }
ApedClipboardContentPart >> initializeValues [ 

	super initializeValues.
	
	elements := OrderedCollection new.
	layouts := OrderedCollection new.
]

{ #category : #accessing }
ApedClipboardContentPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := { 
		#className -> self className.
		#elements -> self elements.
		#layouts -> self layouts.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedClipboardContentPart >> layouts [
	^ layouts
]

{ #category : #accessing }
ApedClipboardContentPart >> layouts: anObject [
	layouts := anObject
]
