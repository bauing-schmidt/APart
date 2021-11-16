Class {
	#name : #APartDescriptionEditorPresenter,
	#superclass : #MASpDescriptionEditorPresenter,
	#instVars : [
		'partClass',
		'generateClassButton',
		'browseButton'
	],
	#category : #'APart-Magritte'
}

{ #category : #'as yet unclassified' }
APartDescriptionEditorPresenter class >> open: aDescription inSpecBackend: backendName class: aPartClass [

	| app conf editor |
	app := SpApplication new.
	conf := SpGtkConfiguration new.
	conf addCSSProviderFromString: '
	box.minHeight200:first-child * {

	min-height: 200px; color:red
	   }
	' withBlanksCondensed.
	app useBackend: backendName with: conf.
	editor := self newApplication: app.
	editor partClass: aPartClass.
	editor description: aDescription.
	editor openWithSpec.
	^ editor
]

{ #category : #accessing }
APartDescriptionEditorPresenter >> buttons [ 

	^ super buttons, #(generateClassButton browseButton)
]

{ #category : #accessing }
APartDescriptionEditorPresenter >> generateClassFrom: aDescription [
	
	| builder |
	builder := APMaClassBuilder new.
	builder existingClass: partClass.
	builder buildClass.
	builder visit: aDescription.
	builder apply.

]

{ #category : #accessing }
APartDescriptionEditorPresenter >> initializePresenters [ 

	super initializePresenters.
			
	generateClassButton := self newButton 
		label: 'Generate class';
		action: [
			self generateClassFrom: description ].		
				
	browseButton := self newButton 
		label: 'Browse';
		action: [ self partClass browse ].		
	
		self refresh
]

{ #category : #accessing }
APartDescriptionEditorPresenter >> partClass [

	^ partClass
]

{ #category : #accessing }
APartDescriptionEditorPresenter >> partClass: anObject [

	partClass := anObject
]
