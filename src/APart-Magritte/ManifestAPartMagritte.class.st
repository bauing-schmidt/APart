"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAPartMagritte,
	#superclass : #PackageManifest,
	#category : #'APart-Magritte-Manifest'
}

{ #category : #'as yet unclassified' }
ManifestAPartMagritte class >> editAspectAccessor [ 

	<script>
	| app conf closedAsSave aDescription p |
	GtkApplication ensureRunning.
	app := SpApplication new.
	conf := SpGtkConfiguration new.
	conf addCSSProviderFromString: '' withBlanksCondensed.
	app useBackend: #Gtk with: conf.
	closedAsSave := false.

	aDescription := MAAspectAccessor new .
	p := aDescription asMASpPresenterIn: app.
	p saveAction: [ closedAsSave := true ].
			
	p openModalWithSpec.

	p commit.

	aDescription inspect
]
