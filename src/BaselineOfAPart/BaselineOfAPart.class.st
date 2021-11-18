"
baseline: spec
   <baseline>
	spec for: #'common' do: [
		
		spec package: 'APart Basic'.
		spec package: 'APart-BasicParts'.
		spec package: 'APart GUI VW8'.
		spec package: 'APart Examples'.
		spec package: 'APart-PharoTests'.

		spec package: 'APart-VisualWorks'.
		spec package: 'APart-Additions'.
	
		spec package: 'APartTest1'.
].
"
Class {
	#name : #BaselineOfAPart,
	#superclass : #BaselineOf,
	#category : #BaselineOfAPart
}

{ #category : #baselines }
BaselineOfAPart >> baseline: spec [
   <baseline>
	spec for: #'common' do: [
		
		self gettext: spec.
		
		spec package: 'APart Basic'.
		spec package: 'APart BasicParts'.
		spec package: 'APart Pharo'.
		spec package: 'APart Patches'.
	
		spec package: 'APart PharoTests-Scopes'.
		spec package: 'APart Localization'.
		
		spec package: 'APart Tests'.
		spec package: 'APart Examples'.
		spec package: 'APart PharoTests'.

		spec package: 'APart Json Support'.
		spec package: 'APart Json Tests'.

		spec package: 'APart Form Editor'.
	]
]

{ #category : #baselines }
BaselineOfAPart >> gettext: spec [

	spec 
		baseline: 'Gettext' 
		with: [ spec repository: 'github://pharo-contributions/Gettext:f020b2b0157d704ff112b7a391a9d69eb39091e7/source' ]

]
