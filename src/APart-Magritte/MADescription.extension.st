Extension { #name : #MADescription }

{ #category : #'*APart-Magritte' }
MADescription >> aspect [

	^ self propertyAt: #aspect ifAbsent: nil
]

{ #category : #'*APart-Magritte' }
MADescription >> aspect: anObject [

	^ self propertyAt: #aspect put: anObject
]

{ #category : #'*APart-Magritte' }
MADescription >> descriptionAspect [
	<magritteDescription>
	^ MAToOneRelationDescription new
		reference: MAStringDescription new;
		accessor: #aspect;
		classes: MAAspectAccessor withAllSubclasses;
		priority: 10;
		yourself
]

{ #category : #'*APart-Magritte' }
MADescription >> editInGtk [ 
	APartDescriptionEditorPresenter open: self inSpecBackend: #Gtk class: self.

]
