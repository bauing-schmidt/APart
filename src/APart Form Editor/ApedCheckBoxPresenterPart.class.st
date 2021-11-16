"
I am a description of a check box presenter
"
Class {
	#name : #ApedCheckBoxPresenterPart,
	#superclass : #ApedFormButtonPresenterPart,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedCheckBoxPresenterPart class >> iconName [

	^ #tcheckbox
]

{ #category : #testing }
ApedCheckBoxPresenterPart class >> isAbstract [ 

	^ false
]

{ #category : #accessing }
ApedCheckBoxPresenterPart class >> label [ 

	^ 'Checkbox'
]

{ #category : #'as yet unclassified' }
ApedCheckBoxPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	label := (aJsonObj at: #label ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	labelClickable := (aJsonObj at: #labelClickable ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #preview }
ApedCheckBoxPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newCheckBox
]
