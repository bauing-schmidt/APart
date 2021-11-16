Class {
	#name : #APBindingsTestPresenter,
	#superclass : #APartRootPresenter,
	#category : #'APart PharoTests-Bindings'
}

{ #category : #specs }
APBindingsTestPresenter class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#stringAspect -> [ aPresenter newTextInput ] 
	}
]

{ #category : #specs }
APBindingsTestPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add: #stringAspect
]

{ #category : #specs }
APBindingsTestPresenter class >> matchingPartClass [

	^ APBindingsTestPart
]
