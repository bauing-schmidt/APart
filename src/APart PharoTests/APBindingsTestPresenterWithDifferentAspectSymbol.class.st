Class {
	#name : #APBindingsTestPresenterWithDifferentAspectSymbol,
	#superclass : #APBindingsTestPresenter,
	#category : #'APart PharoTests-Bindings'
}

{ #category : #specs }
APBindingsTestPresenterWithDifferentAspectSymbol class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#stringPresenter -> [ 
			aPresenter newTextInput
				aspectSymbol: #stringAspect;
				yourself.	 ] 
	}
]

{ #category : #specs }
APBindingsTestPresenterWithDifferentAspectSymbol class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add: #stringPresenter
]
