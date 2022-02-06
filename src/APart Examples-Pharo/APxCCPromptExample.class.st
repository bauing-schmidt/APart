Class {
	#name : #APxCCPromptExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-Pharo'
}

{ #category : #API }
APxCCPromptExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#promptYesNo -> [  aPresenter newButton label: 'Prompt Yes/No'   ].
		#promptMulti -> [  aPresenter newButton label: 'Prompt Multi'   ].
		#promptSingle -> [  aPresenter newButton label: 'Prompt Single'   ].
		#promptButtons -> [  aPresenter newButton label: 'Prompt Buttons'   ].
		#promptReport -> [  aPresenter newButton label: 'Prompt Report'   ].
		#promptColor -> [  aPresenter newButton label: 'Prompt Color'   ].
		#promptFile -> [  aPresenter newButton label: 'Prompt File'   ].
		#promptText -> [  aPresenter newButton label: 'Prompt Text'   ].
		#promptMultilineText -> [  aPresenter newButton label: 'Prompt Multiline Text'   ].
		#promptWarning -> [  aPresenter newButton label: 'Prompt Warning'   ].
	 }.

]

{ #category : #API }
APxCCPromptExample class >> defaultLayout [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.

	(self associatedPresentersFor: nil) keysDo: [ :aKey |
		aLayout add: aKey ].
		
	^ aLayout
]

{ #category : #API }
APxCCPromptExample class >> matchingPartClass [

	^APxCCPromptExamplePart
]
