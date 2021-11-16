Class {
	#name : #APTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests-Bindings'
}

{ #category : #support }
APTest >> for: aPresenterClass performTest: aBlockPartForm [ 
	| part aPresenter app |
	
	SpBindings 
		value: SpStubAdapterBindings
		during: [
			app := SpMockApplication new.
			part := aPresenterClass createRootPart.
			aPresenter := (aPresenterClass openOnPart: part application: app) presenter.
			aBlockPartForm value: part value: aPresenter ]
]
