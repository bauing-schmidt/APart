"
Presenter base class for top presenters only
"
Class {
	#name : #APartRootPresenter,
	#superclass : #APartPresenter,
	#category : #'APart Pharo'
}

{ #category : #'interface opening' }
APartRootPresenter class >> createRootPart [

	^self matchingPartClass createWithClientRegistry
]

{ #category : #'interface opening' }
APartRootPresenter class >> open [

	^ self openOnPart: self createRootPart
]

{ #category : #'interface opening' }
APartRootPresenter class >> openWithSpec: aSymbol [
	"Convenience to open views with RootState directly from windowSpec method"
	
	^self openOnPart: self createRootPart withSpec: aSymbol
]
