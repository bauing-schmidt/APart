Class {
	#name : #APxSpecTest,
	#superclass : #ClassTestCase,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxSpecTest >> classToBeTested [
	
	"just to be abstract"
	^ APxSpecTest
]

{ #category : #tests }
APxSpecTest >> performTest: aBlockPartForm [
	| part form app |
	
	SpBindings
		value: SpStubAdapterBindings
		during: [
			app := SpMockApplication new.
			part := self classToBeTested createRootPart.
			form := (self classToBeTested openOnPart: part application: app) presenter.
			aBlockPartForm value: part value: form ]
]
